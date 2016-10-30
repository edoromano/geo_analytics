class AddCityToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :city, :string
  end
end
