class UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # IMPORTANT: move off of user_id being used in session
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Account created successfully"
    else
      redirect_to signup_path, alert: "Failed to create account"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else 
      redirect_to edit_user_path(@user), alert: "Failed to update user"
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
