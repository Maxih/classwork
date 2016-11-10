class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :auth_token, :log_in_user!, :current_user, :logged_in?

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def auth_token
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">".html_safe
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end
end
