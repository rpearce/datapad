class AddDisplayValueAndSearchTextToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :display_value, :string, null: false
    add_column :affiliations, :search_text, :string
  end
end
