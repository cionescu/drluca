# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string
#  question_id :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

FactoryGirl.define do
  factory :user do
    name "MyString"
  end
end
