class PasswordResetsController < ApplicationController

  before_action :verify_token, only: [:edit, :update]

  def new
  end

  # Send pw reset email
  def create
    @user = User.find_by(email: params[:email])
    if @user
      token = @user.generate_password_reset_token
      UserMailer.with(user: @user, token: token).password_reset.deliver_now
      flash[:info] = "Password reset instructions will be sent to your email if a user with that email exists."
      redirect_to login_path
    else
      flash[:info] = "Password reset instructions will be sent to your email if a user with that email exists."
      redirect_to login_path
    end
  end
  
  # Show pw reset form (via email link)
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Password successfully reset."
      redirect_to login_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def verify_token
    @user = User.verify_password_reset_token(params[:token])
    unless @user
      flash[:danger] = "Invalid or expired password reset token."
      redirect_to new_password_reset_path
    end
  end
end
