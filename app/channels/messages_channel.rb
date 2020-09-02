class MessagesChannel < ApplicationCable::Channel

  def subscribed
    # Each user has a unique channel to send private messages just to them.
    # MessagesController#create does the broadcast to this channel when a
    # user creates a new message via an ajax request in the front end (main.js)
    # JavaScript is listening for messages broadcast to this user's channel
    # in the file app/assets/javascripts/channels/messages.js
    stream_from "messages_#{connection.current_user.id}"
  end

end
