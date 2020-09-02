class MessagesController < ApplicationController

  before_action :check_if_logged_in

  def new
  end

############################################################################
  def create
    @message = Message.create content: params[:content], recipient_id: params[:recipient_id], sender_id: @current_user.id
    # p @message.errors.full_messages
    if @message.save
      # JavaScript is listening for messages broadcast to this user's channel
      # in the file app/assets/javascripts/channels/messages.js
      ActionCable.server.broadcast "messages_#{params[:recipient_id]}",
        message: @message,
        user: @message.sender
    end

    # we respond to the ajax request with the created message object
    # so that in the Ajax .done handler, we can append the created message
    # to the sender's list of messages (the sender does not receive the broadcast
    # over ActionCable because the broadcast is directed to the recipient's
    # channel only).
    render json: @message, include: [:sender, :recipient]

  end




  def index
    @messaged_friends = @current_user.all_messaged_friends
  end

  def show
    @recipient_id = params[:id]
    @conversation_messages = (Message.where(["sender_id = ? and recipient_id = ?", @current_user.id, @recipient_id]) + Message.where(["sender_id = ? and recipient_id = ?", @recipient_id, @current_user.id])).sort_by(&:created_at)

    @message = Message.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def message_search
    messages = Message.where(sender_id: @current_user.id).or(Message.where(recipient_id: @current_user.id)).includes(:sender, :recipient)

    render json: messages, include: [:sender, :recipient]
  end

  def message_show
    messages = Message.where(sender_id: @current_user.id, recipient_id: params[:query]).or(Message.where(sender_id: params[:query], recipient_id: @current_user.id)).includes(:sender, :recipient)

    render json: messages, include: [:sender, :recipient]
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :content, :attachment)
  end
end
