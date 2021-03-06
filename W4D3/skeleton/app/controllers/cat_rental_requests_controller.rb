class CatRentalRequestsController < ApplicationController

  before_action :validate_user, only: [:approve, :deny]

  def validate_user
    unless current_user && current_user.id == current_cat_rental_request.user_id
      flash[:errors] = ["Invalid permissions"]
      redirect_to cats_url
    end
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    if current_user && current_user.id != @rental_request.cat.owner.id
      @rental_request.user_id = current_user.id
      if @rental_request.save
        redirect_to cat_url(@rental_request.cat)
      else
        flash.now[:errors] = @rental_request.errors.full_messages
        render :new
      end
    else
      flash[:errors] = ["You cant rent that cat"]
      redirect_to cats_url
    end

  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end
end
