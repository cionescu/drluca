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

class UserSerializer < ActiveModel::Serializer
  attributes :name, :quiz, :status, :correct, :wrong, :total_score

  def quiz
    object.quiz.name
  end

  def correct
    object.score.select{ |obj| obj }.count
  end

  def wrong
    object.score.select{ |obj| !obj }.count
  end

  def total_score
    object.score.count
  end
end
