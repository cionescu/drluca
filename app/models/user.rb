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

class User < ApplicationRecord
  CHANNEL = "user_channel".freeze

  belongs_to :quiz

  enum status: {
    online: 0,
    offline: 1
  }

  def self.broadcast_for quiz
    users = quiz.users.online.map do |user|
      UserSerializer.new(user).as_json
    end
    ActionCable.server.broadcast User::CHANNEL, message: users
  end

  def answered answer
    self.score << answer
    save!
  end
end
