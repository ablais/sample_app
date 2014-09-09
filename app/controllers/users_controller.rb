class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @count_active = User.active_count.count
    @count = User.count
    @usernum = @user["id"]
  end
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def avatar
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.changed?
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash[:error] = "Error: No Changes Made"
    #  render 'edit'
      redirect_to :back
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end
    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end
    def user_params2
      params.require(:user).permit(:avatar)
    end

    # Before filters
    
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
