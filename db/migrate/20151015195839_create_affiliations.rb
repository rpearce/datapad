class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
