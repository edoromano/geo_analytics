class AddPriceToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :price, :string
  end
end
