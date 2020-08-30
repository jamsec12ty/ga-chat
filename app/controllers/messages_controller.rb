class MessagesController < ApplicationController
  def new
  end

  def create
  end

  def index
    @current_user = User.find(55)
    @messaged_friends = @current_user.all_messaged_friends
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
