class RemovePriceFromHouses < ActiveRecord::Migration
  def change
    remove_column :houses, :price, :decimal
  end
end
