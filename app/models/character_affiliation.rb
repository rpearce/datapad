class CharacterAffiliation < ActiveRecord::Base
  belongs_to :character
  belongs_to :affiliation

  validates :character_id, presence: true, uniqueness: { scope: :affiliation_id }
  validates :affiliation_id, presence: true
end
