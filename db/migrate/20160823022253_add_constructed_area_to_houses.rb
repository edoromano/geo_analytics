class AddConstructedAreaToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :constructed_area, :string
  end
end
