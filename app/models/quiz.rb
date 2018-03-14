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
    update!(current_question: 0)
    in_progress!
    question = Question.find(questions[0])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
  end

  def broadcast_current_question
    return unless in_progress? && current_question.present?
    question = Question.find(questions[current_question])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
  end
end
