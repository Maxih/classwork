class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user ||= User.new
    user
  end

  def logged_in?
    !current_user.id.nil?
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def check_status
    flash[:errors] = ["You must log in to create content"]
    redirect_to new_session_url
  end

end
