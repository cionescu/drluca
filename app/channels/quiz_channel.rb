class QuizChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quiz_channel"
    Rails.logger.warn params.inspect
    user = User.find_or_initialize_by(name: params[:name])
    quiz = Quiz.find(params[:quiz])
    user.update!(quiz: quiz)
    users = quiz.users.map do |user|
      UserSerializer.new(user).as_json
    end
    ActionCable.server.broadcast 'quiz_channel', message: users
  end

  def unsubscribed
  end
end
