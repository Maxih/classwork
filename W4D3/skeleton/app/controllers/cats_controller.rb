class CatsController < ApplicationController
  before_action :valid_permissions?, only: [:edit, :update]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.where(id: params[:id]).includes(:rental_requests).first
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def valid_permissions?
    if current_user
      @cat = current_user.cats.where(id: params[:id]).first
      unless current_user && @cat && current_user.id == @cat.user_id
        invalid_permissions
      end
    else
      invalid_permissions
    end
  end

  def invalid_permissions
    flash[:errors] = ["This cat does not belong to you"]
    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
