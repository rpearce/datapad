class Api::CharactersController < ApplicationController
  def index
    respond_to do |format|
      format.json { @characters = Character.includes([:affiliations, :character_affiliations]).all }
    end
  end
end
