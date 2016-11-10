class AddAreaToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :area, :string
  end
end
