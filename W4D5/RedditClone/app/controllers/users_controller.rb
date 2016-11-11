class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in(user)

    else
      flash[:errors] = ["Registration failed"]
    end
    redirect_to subs_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
