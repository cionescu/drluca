# == Schema Information
#
# Table name: quizzes
#
#  id               :integer          not null, primary key
#  name             :string
#  questions        :jsonb
#  current_question :integer
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Quiz < ApplicationRecord
  has_many :users

  CHANNEL = "quiz_channel".freeze

  enum status: {
    ready: 0,
    in_progress: 1,
    finished: 2
  }

  def start_quiz! count = 10
    reset_user_scores
    assign_questions(count)
    update!(current_question: 0)
    in_progress!
    broadcast_current_question
  end

  def start_themed_quiz! category: :surgical_tools, count: 20
    reset_user_scores
    assign_themed_questions(category, count)
    update!(current_question: 0)
    in_progress!
    broadcast_current_question
  end

  def broadcast_current_question
    return unless in_progress? && current_question.present?
    question = Question.find(questions[current_question])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
    User.broadcast_for self
  end

  def next_question
    if users_still_need_to_answer?
      Rails.logger.warn "There are #{users.online.count} users. They answered: #{users.online.map{|u| u.score.count}.join(',')} questions. Current: #{current_question}"
      return
    end
    if current_question == questions.count - 1
      finished!
      Rails.logger.warn "FINISHED THE QUIZ"
      ActionCable.server.broadcast CHANNEL, finished: true
      User.broadcast_for self
    else
      increment! :current_question
      broadcast_current_question
    end
  end

  def assign_questions count
    question_ids = []
    category_count = Question.categories.count
    while question_ids.count < count
      category = Question.categories.key(rand(Question.categories.count))
      question = Question.where.not(id: question_ids).where(category: category).order("random()").first or next
      question_ids << question.id
    end
    update!(questions: question_ids.shuffle)
  end

  def assign_themed_questions category, count
    update!(questions: Question.where(category: category).order("random()").limit(count).pluck(:id))
  end

  private

  def reset_user_scores
    users.update_all(score: [])
  end

  def users_still_need_to_answer?
    users.online.any? do |user|
      user.score.count != current_question + 1
    end
  end
end
