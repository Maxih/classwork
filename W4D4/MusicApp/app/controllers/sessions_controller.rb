class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user
      self.log_in_user!(user)
    end

    redirect_to bands_url
  end

  def destroy
    user = User.find_by_session_token(session[:session_token])
    user.reset_session_token!

    session[:session_token] = nil

    redirect_to bands_url
  end
end
