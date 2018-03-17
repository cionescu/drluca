# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  title             :string
#  url               :string
#  incorrect_answers :jsonb
#  answer            :string
#  autogenerated     :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category          :integer          default(0)
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :answer, :incorrect_answers, :answers

  def answers
    arr = object.incorrect_answers + [object.answer]
    arr.shuffle
  end
end
