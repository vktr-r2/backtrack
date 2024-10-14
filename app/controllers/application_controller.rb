class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # Makes current_user method available in views. By default, all methods defined in Application Controller are available in the controllers.
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to login_path unless current_user, alert: "You must be logged in to view this page"
  end
end
