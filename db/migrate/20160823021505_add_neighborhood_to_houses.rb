class AddNeighborhoodToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :neighborhood, :string
  end
end
