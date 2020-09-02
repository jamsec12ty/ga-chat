class ConversationsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "conversations"
  end

end
