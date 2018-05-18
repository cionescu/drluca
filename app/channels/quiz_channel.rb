class QuizChannel < ApplicationCable::Channel
  def subscribed
    stream_from Quiz::CHANNEL
    quiz = Quiz.find_by!(name: params[:quiz])
    quiz.broadcast_current_question
  end

  def correct
    handle_answer true
  end

  def wrong
    handle_answer false
  end

  private

  def handle_answer correct
    quiz = Quiz.find_by!(name: params[:quiz])
    user = User.find_by!(name: params[:user])
    user.answered(correct)
    Rails.logger.warn "QuizChannel Selected user after: #{user.score.inspect}"
    quiz.next_question
  end
end
