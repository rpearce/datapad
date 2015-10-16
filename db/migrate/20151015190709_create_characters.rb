class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :image
      t.string :name
      t.string :homeworld
      t.string :species
      t.text   :summary
      t.string :external_uri

      t.timestamps null: false
    end
  end
end
