class AddRoomsToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :rooms, :string
  end
end
