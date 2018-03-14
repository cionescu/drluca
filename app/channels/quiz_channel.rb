class QuizChannel < ApplicationCable::Channel
  def subscribed
    stream_from Quiz::CHANNEL
    quiz = Quiz.find_by!(name: params[:quiz])
    quiz.broadcast_current_question
  end

  def selected
    quiz = Quiz.find_by!(name: params[:quiz])
    user = User.find_by!(name: params[:user])
    quiz.next_question
  end
end
