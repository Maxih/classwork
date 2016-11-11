class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      log_in(user)

    else
      flash[:errors] = ["Could not log in"]
    end
      redirect_to subs_url
  end

  def destroy
    log_out
    redirect_to subs_url
  end

end
