class MessagesController < ApplicationController

  before_action :check_if_logged_in

  def new
  end

  def create
    @message = Message.create content: params[:content], recipient_id: params[:recipient_id], sender_id: @current_user.id
    render json: @message, include: [:sender, :recipient]
  end

  def index
    @messaged_friends = @current_user.all_messaged_friends

    @message = Message.new
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
