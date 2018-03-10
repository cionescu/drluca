class QuizChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quiz_channel"
  end

  def unsubscribed
  end
end
