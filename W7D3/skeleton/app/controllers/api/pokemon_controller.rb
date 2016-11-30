class Api::PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all
    render :index
  end

  def show
    @pokemon = Pokemon.where(id: params[:id]).includes(:items).first
    
    render :show
  end
end
