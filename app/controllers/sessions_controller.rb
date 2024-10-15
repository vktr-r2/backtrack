class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path, allow_other_host: true, notice: "Logged in successfully"
    else
      redirect_to login_path, allow_other_host: true, alert: "Invalid email or password"
    end 
  end 

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
