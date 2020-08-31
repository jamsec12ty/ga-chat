class UsersController < ApplicationController
  before_action :check_if_logged_in, except: [:new, :create]

    def new
      @user = User.new
    end #new


    def create
      @user = User.create user_params
      if @user.persisted?
        session[:user_id] = @user.id #log in the newly created account automatically!
        redirect_to messages_path
      else
        render :new
      end #else
    end #create



    def index
    end



    def show
      @user = User.find params[:id]
      # redirect_to(user_path(params[:id])) unless @user.id == @current_user.id
    end



    def edit
      @user = User.find params[:id] #from /users/:id
      redirect_to(user_path(params[:id])) unless @user.id == @current_user.id
    end



    def update
      @user = User.find params[:id] #from /users/:id
        if @user.id != @current_user.id
          redirect_to(user_path(params[:id]))
          return
        end
      @user.update user_params
      redirect_to user_path(@user)
    end



    def destroy
    end



    ############################################
    private

    def user_params
      params.require(:user).permit( :name, :email, :password, :password_confirmation, :image)
    end # user_params


end
