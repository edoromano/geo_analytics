class AddBathroomsToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :bathrooms, :string
  end
end
