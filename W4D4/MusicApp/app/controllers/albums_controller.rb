class AlbumsController < ApplicationController
  before_action :check_priveledges

  def check_priveledges
    unless logged_in?
      flash[:errors] = ["You must be logged in to view this"]
      redirect_to new_session_url
    end
  end

  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    @album.band_id = params[:band_id]

    if @band
      render :new
    else
      flash[:errors] = ["Invalid band id supplied"]
      redirect_to bands_url
    end
  end

  def create
    album = Album.new(album_params)

    if album.save
      redirect_to album_url(album.id)
    else
      flash[:errors] = ["Invalid band id supplied"]
      redirect_to bands_url
    end
  end

  def show
    @album = Album.where(id: params[:id]).includes(:tracks).first
    render :show
  end

  def destroy
    album = Album.find(params[:id])

    if album.destroy

    else
      flash[:errors] = ["Could not be deleted"]
    end

    redirect_to bands_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :album_type, :band_id)
  end
end
