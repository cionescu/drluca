class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from User::CHANNEL
    user = User.find_or_initialize_by(name: params[:user])
    quiz = Quiz.find_by!(name: params[:quiz])
    user.quiz = quiz
    user.save!
    user.online!
    User.broadcast_for(quiz)
  end

  def unsubscribed
    Rails.logger.warn params.inspect
    quiz = Quiz.find_by!(name: params[:quiz])
    if user = User.find_by(name: params[:user])
      user.offline!
      User.broadcast_for(quiz)
    end
  end
end
