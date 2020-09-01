class FriendsController < ApplicationController
  before_action :check_if_logged_in

  # CREATE

  def new
    @friends = Friendship.all
    @friend = Friendship.new
    @users = User.all
  end

  def create
    Friendship.create friend_params
    redirect_to friends_path
  end

  # READ

  def index
    @friends = @current_user.friends
  end

  def show
    @friend = Friendship.find params[:id]
  end

  # UPDATE

  def edit
    @friend = Friendship.find params[:id]
  end

  def update
    friend = Friendship.find params[:id]
    Friendship.update friend_params

    redirect_to( friend_path(params[:id]) )
  end

  # DELETE

  def destroy
    Friendship.destroy params[:id]
    redirect_to friends_path
  end

  private
  def friend_params
    params.require(:friend).permit(:user_id, :friend_id, :status, :search)

  end
end #
