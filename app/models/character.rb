class Character < ActiveRecord::Base
  has_many :character_affiliations, dependent: :destroy
  has_many :affiliations, through: :character_affiliations

  validates :name, uniqueness: true
end
