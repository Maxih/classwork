class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if user
      session[:session_token] = user.reset_session_token!
    else
      flash[:errors] = ['Failed to login, invalid credentials']
    end

    redirect_to cats_url
  end

  def destroy
    if self.current_user
      sessions = Session.find_by(token: session[:session_token])
      Session.destroy(sessions.id) if sessions
      session[:session_token] = nil
    end



    redirect_to cats_url
  end


end
