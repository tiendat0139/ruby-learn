class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end
  
  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the DBLog #{@user.username}"
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit

  end

  def destroy
    @user.destroy
    redirect_to users_path
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:notice] = "You cannot edit this user"
      redirect_to user_path(@user)
    end
  end
end
