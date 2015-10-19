class AddOrderToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :order, :integer, default: 0, null: false
  end
end
