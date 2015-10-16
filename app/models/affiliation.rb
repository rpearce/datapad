class Affiliation < ActiveRecord::Base
  has_many :character_affiliations, dependent: :destroy
  has_many :characters, through: :character_affiliations

  validates :name, presence: true, uniqueness: true
  validates :display_value, presence: true
end
