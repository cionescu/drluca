# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  quiz_id    :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  score      :jsonb
#
# Indexes
#
#  index_users_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#

FactoryGirl.define do
  factory :user do
    name "MyString"
  end
end
