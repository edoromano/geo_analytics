class AddFloorsToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :floors, :string
  end
end
