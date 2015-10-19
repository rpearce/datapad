class Api::CharactersController < ApplicationController
  def index
    respond_to do |format|
      format.json {
        @characters = Character.includes([:affiliations, :character_affiliations])
        @characters = @characters.where('characters.name ILIKE ?', "%#{params[:q]}%") if params[:q]
        @characters = @characters.where('affiliations.name = ?', params[:type]).references(:affiliations) if params[:type]
      }
    end
  end
end
