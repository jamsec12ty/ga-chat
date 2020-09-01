class FriendshipsController < ApplicationController

  before_action :check_if_logged_in

  # CREATE

  def new
    @friendships = Friendship.all
    @friendship = Friendship.new
    @users = User.all
  end

  def create
    Friendship.create friendship_params
    redirect_to friendships_path
  end

  # READ

  def index
    @friends = @current_user.friends
  end

  def show
    @friendship = Friendship.find params[:id]
  end

  # UPDATE

  def edit
    @friendship = Friendship.find params[:id]
  end

  def update
    friendship = Friendship.find params[:id]
    Friendship.update friendship_params

    redirect_to( friendship_path(params[:id]) )
  end

  # DELETE

  def destroy
    Friendship.destroy params[:id]
    redirect_to friendships_path
  end

  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status, :search)

  end
end #
