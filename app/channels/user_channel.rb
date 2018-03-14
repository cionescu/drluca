class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from User::CHANNEL
    user = User.find_or_initialize_by(name: params[:user])
    quiz = Quiz.find_by!(name: params[:quiz])
    user.quiz = quiz
    user.save!
    users = quiz.users.map do |user|
      UserSerializer.new(user).as_json
    end
    ActionCable.server.broadcast User::CHANNEL, message: users
  end

  def unsubscribed
  end
end
