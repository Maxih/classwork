class BandsController < ApplicationController
  before_action :check_priveledges

  def check_priveledges
    unless logged_in?
      flash[:errors] = ["You must be logged in to view this"]
      redirect_to new_session_url
    end
  end


  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    band = Band.new(band_params)

    if band.save
      redirect_to band_url(band.id)
    else
      flash[:errors] = ["Unable to create band #{band.name}"]
      redirect_to bands_url
    end
  end

  def edit
    render :edit
  end

  def update
    band = Band.find(params[:id])

    if band.update(band_params)
      redirect_to band_url(band.id)
    else
      flash[:errors] = ["Unable to change band name"]
      redirect_to bands_url
    end
  end

  def show
    @band = Band.where(id: params[:id]).includes(:albums).first

    if @band
      render :show
    else
      flash[:errors] = ["Invalid band url"]
      redirect_to bands_url
    end
  end

  def destroy
    @band = Band.find(params[:id])

    if @band.destroy

    else
      flash[:errors] = ["Couldnt delete band"]
    end

    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end
