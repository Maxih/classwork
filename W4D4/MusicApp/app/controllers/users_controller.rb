class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)
    user.save!

    if user
      self.log_in_user!(user)
    else
      flash[:errors] = ["Unable to create new user"]
      redirect_to new_user_url
    end

    redirect_to bands_url(user.id)
  end

  def show
    @user = User.find(params[:id])

    if @user
      render :show
    else
      flash[:errors] = ["Invalid user"]
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
