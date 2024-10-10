class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the user by email
    user = User.find_by(email: params[:email])
    # If the user exists and the password is correct
    if user && user.authenticate(params[:password])
      # Save the user_id in the session
      session[:user_id] = user.id
      # Redirect to the dashboard
      redirect_to dashboard_path, notice: "Logged in successfully"
    else
      # Otherwise, redirect to the login page
      redirect_to login_path, alert: "Invalid email or password"
    end
  end

  def destroy
    # Remove the user_id from the session
    session[:user_id] = nil
    # Redirect to the login page
    redirect_to login_path, notice: "Logged out successfully"
  end
end
