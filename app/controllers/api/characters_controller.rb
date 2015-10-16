class Api::CharactersController < ApplicationController
  def index
    respond_to do |format|
      format.json {
        @characters = Character.includes([:affiliations, :character_affiliations])
        @characters = @characters.where('name ILIKE ?', "%#{params[:q]}%") if params[:q]
        #@characters = @characters.where() if params[:type]
      }
    end
  end
end
