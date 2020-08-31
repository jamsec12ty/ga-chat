class MessagesController < ApplicationController

  before_action :check_if_logged_in

  def new
  end

  def create
    @message = Message.create message_params
    # if @message.persisted?
    @current_user.sent_messages << @message
    # end
    redirect_to(message_path(message_params[:recipient_id]))
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
    render json: Message.where(sender_id: @current_user.id).or(Message.where(recipient_id: @current_user.id))
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :content, :attachment)
  end
end
