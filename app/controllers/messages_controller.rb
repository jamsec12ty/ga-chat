class MessagesController < ApplicationController
  def new
  end

  def create
    @current_user = User.first
    @message = Message.create message_params
    # if @message.persisted?
    @current_user.sent_messages << @message
    # end
    # raise "hell"
    redirect_to(message_path(message_params[:recipient_id]))
  end

  def index
    @current_user = User.first
    @messaged_friends = @current_user.all_messaged_friends

    @recipient_id = @messaged_friends.first.id
    
    # railse "hell"
  end
  
  def show
    @current_user = User.first
    # railse "hell"
    @recipient_id = params[:id]
    @conversation_messages = (Message.where(["sender_id = ? and recipient_id = ?", @current_user.id, @recipient_id]) + Message.where(["sender_id = ? and recipient_id = ?", @recipient_id, @current_user.id])).sort_by(&:created_at)

    @message = Message.new
    # redirect_to(messages_path)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :content, :attachment)
  end
end
