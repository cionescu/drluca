# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  url        :string
#  answers    :jsonb
#  correct    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :question do
    title "MyString"
    url "MyString"
    answers ""
    correct "MyString"
  end
end