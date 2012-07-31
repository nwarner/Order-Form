class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:show, :edit, :update]
  before_filter :admin_user, only: [:index, :destroy]
  
  def show
    @user = User.find(params[:id])
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      
      # send a welcome email
      UserMailer.welcome_email(@user).deliver

      sign_in @user
      flash[:success] = "Welcome to Order Form!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products.paginate(page: params[:page])
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user?(@user) || current_user.admin?)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
