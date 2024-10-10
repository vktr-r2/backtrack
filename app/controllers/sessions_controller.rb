class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      redirect_to login_path, alert: "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
