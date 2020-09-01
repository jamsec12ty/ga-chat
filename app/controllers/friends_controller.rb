class FriendsController < ApplicationController
  before_action :check_if_logged_in

  # CREATE

  def new
  end

  def create
    # raise "hell"
    Friendship.create(user_id: @current_user.id, friend_id: params[:user_id], status: "pending" )
    redirect_to user_path(params[:user_id])
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
    @friendship = Friendship.where(user_id: params[:user_id], friend_id: @current_user.id)
  end

  def update
    @friendship = Friendship.where(user_id: params[:user_id], friend_id: @current_user.id)

    @friendship.update(status: "confirmed")

    redirect_to user_path(params[:user_id])
  end

  # DELETE

  def destroy
    Friendship.destroy params[:id]
    redirect_to friends_path
  end

end #
