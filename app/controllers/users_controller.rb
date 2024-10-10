class UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Log the user in and redirect to dashboard
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Account created successfully"
    else
      redirect_to signup_path, alert: "Failed to create account"
    end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
