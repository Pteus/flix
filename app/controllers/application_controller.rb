class  ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_user?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  add_flash_types :danger

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def require_login
    session[:intended_url] = request.url

    unless current_user
      redirect_to signin_path, alert: "You must be logged in to access this page."
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end
end
