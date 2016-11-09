class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    # user = User.find_by_credentials(
    #   params[:user][:user_name],
    #   params[:user][:password]
    # )
    user = User.new(users_params)
    if user.save
      session[:session_token] = user.reset_session_token!
      redirect_to cats_url
    else

    end
  end

  private

  def users_params
    params.require(:user).permit(:user_name, :password)
  end

end
