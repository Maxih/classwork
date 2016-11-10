class NotesController < ApplicationController
  def create
    note = Note.new(note_params)

    note.user_id = current_user.id

    if note.save
      redirect_to track_url(note.track_id)
    else
      flash[:errors] = ["Error occured"]
      redirect_to bands_url
    end

  end

  def destroy
    note = Note.find(params[:id])

    track_id = note.track_id

    if note.destroy

    else
      flash[:errors] = ["Unable to create band #{band.name}"]
    end

    redirect_to track_url(track_id)
  end

  private

  def note_params
    params.require(:note).permit(:note, :track_id)
  end
end
