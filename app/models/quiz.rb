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

  def start_quiz!
    update!(current_question: 0)
    question = Question.find(questions[0])
    ActionCable.server.broadcast CHANNEL, QuestionSerializer.new(question).as_json
  end
end
