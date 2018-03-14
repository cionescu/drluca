class QuizChannel < ApplicationCable::Channel
  def subscribed
    stream_from Quiz::CHANNEL
    Rails.logger.warn params.inspect
    quiz = Quiz.find_by!(name: params[:quiz])
  end
end
