class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from User::CHANNEL
    Rails.logger.warn params.inspect
    user = User.find_or_initialize_by(name: params[:user])
    quiz = Quiz.find(params[:quiz])
    user.quiz = quiz
    user.save!
    Rails.logger.warn user.inspect
    Rails.logger.warn quiz.inspect
    users = quiz.users.map do |user|
      Rails.logger.warn user.inspect
      UserSerializer.new(user).as_json
    end
    ActionCable.server.broadcast User::CHANNEL, message: users
  end

  def unsubscribed
  end
end
