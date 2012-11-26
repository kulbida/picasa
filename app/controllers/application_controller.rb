class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

private

  def current_user
    if session[:uid].present?
      @current_user ||= User.find_by_id(session[:uid]) 
    end
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to(root_path, :notice => 'You need to login first to access this page.') unless logged_in?
  end

end
