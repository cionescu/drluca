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

  def start_quiz!
    reset_user_scores
    update!(current_question: 0, questions: questions.shuffle)
    in_progress!
    question = Question.find(questions[0])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
  end

  def broadcast_current_question
    return unless in_progress? && current_question.present?
    question = Question.find(questions[current_question])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
    User.broadcast_for self
  end

  def next_question
    Rails.logger.warn [current_question, questions.count].inspect
    if current_question == questions.count - 1
      finished!
      Rails.logger.warn "FINISHED THE QUIZ"
      ActionCable.server.broadcast CHANNEL, finished: true
    else
      if users_still_need_to_answer?
        Rails.logger.warn "Users Still need to answer"
        Rails.logger.warn "There are #{users.online.count} users. They answered: #{users.online.map{|u| u.score.count}.join(',')} questions. Current: #{current_question}"
        return
      end
      increment! :current_question
      broadcast_current_question
    end
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
