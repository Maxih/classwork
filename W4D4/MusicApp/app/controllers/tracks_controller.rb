class TracksController < ApplicationController
  before_action :check_priveledges

  def check_priveledges
    unless logged_in?
      flash[:errors] = ["You must be logged in to view this"]
      redirect_to new_session_url
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new()
    @track.album_id = params[:album_id]

    render :new
  end

  def create
    track = Track.new(track_params)

    if track.save
      redirect_to track_url(track.id)
    else
      flash[:error] = ["Unable to add track"]
      redirect_to bands_url
    end
  end

  def show
    @track = Track.where(id: params[:id]).includes(:album).includes(:notes).first
    render :show
  end

  def destroy
    track = Track.find(params[:id])

    if track.destroy

    else
      flash[:errors] = ["Could not be deleted"]
    end

    redirect_to bands_url
  end

  private

  def track_params
    params.require(:track).permit(:title, :lyrics, :track_type, :album_id)
  end
end
