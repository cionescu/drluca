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

FactoryGirl.define do
  factory :quiz do
    name "MyString"
    questions ""
    current_question 1
  end
end
