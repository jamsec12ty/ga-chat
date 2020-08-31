class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]
    if user.present? && user.authenticate( params[:password] )
      session[:user_id] = user.id
      redirect_to messages_path
    else
      flash[:error] = 'Invalid email or password'
      redirect_to login_path
    end #login check
  end # create
  #############################################

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end # destroy

###############################################

  def home

  end # home
end
