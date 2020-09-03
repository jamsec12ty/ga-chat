class UsersController < ApplicationController
  before_action :check_if_logged_in, except: [:new, :create]

  def new
    @user = User.new
  end #new


  def create
    @user = User.create user_params
    if @user.persisted?
      session[:user_id] = @user.id #log in the newly created account automatically!
      redirect_to user_friends_path(@user.id)
    else
      render :new
    end #else
  end #create



  def index
    # @user = User.all
  end



  def show
    @user = User.find params[:id]

    # redirect_to(user_path(params[:id])) unless @user.id == @current_user.id

    @friend = Friendship.new

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
    if params[:file].present?
      response = Cloudinary::Uploader.upload params[:file]
      @user.image = response['public_id']
      @user.save
      # raise "hell"
      @user.update user_params
    end
    redirect_to user_path(@user)
  end


  def destroy
  end

  def user_search
    render json: User.where("name ILIKE ?", "%#{params[:query]}%")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end # user_params

end
