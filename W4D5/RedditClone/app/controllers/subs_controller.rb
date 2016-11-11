class SubsController < ApplicationController
  before_action :check_status, only:[:create, :new, :destroy, :edit, :update], unless: :logged_in?

  def create
    new_sub = Sub.new(sub_params)
    new_sub.user_id = current_user.id

    if new_sub.save
      redirect_to sub_url(new_sub)
    else
      flash[:errors] = ["Could not create sub"]
      redirect_to subs_url
    end
  end

  def index
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def destroy
    kill_sub = Sub.find(params[:id])
    if kill_sub
      kill_sub.destroy
    else
      flash[:errors] = ["Could not delete sub"]
    end
    redirect_to subs_url
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    updated_sub = Sub.find(params[:id])

    if updated_sub.user_id == current_user.id
      if updated_sub.update(sub_params)
        redirect_to sub_url(updated_sub)
      else
        flash[:errors] = ["Could not update sub"]
        redirect_to subs_url
      end
    else
      flash[:errors] = ["This is not your sub to moderate"]
      redirect_to subs_url
    end
  end

  def show
    @sub = Sub.where(id: params[:id]).includes(:posts).first
    render :show
  end

  def index
    render :index
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
