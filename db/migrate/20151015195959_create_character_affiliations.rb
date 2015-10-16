class CreateCharacterAffiliations < ActiveRecord::Migration
  def change
    create_table :character_affiliations do |t|
      t.integer :character_id, null: false
      t.integer :affiliation_id, null: false

      t.timestamps null: false
    end

    add_index :character_affiliations, [:character_id, :affiliation_id], unique: true
  end
end
