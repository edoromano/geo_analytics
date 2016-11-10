class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :price, default: "0.0"
      t.string :city, default: ""
      t.string :neighborhood, default: ""
      t.integer :floors, default: 0
      t.integer :rooms, default: 0
      t.string :area, default: "0.0"
      t.integer :bathrooms, default: 0
      t.boolean :published, default: false
      t.decimal :latitude, default: 25.6667, :precision => 10, :scale => 7
      t.decimal :longitude, default: -100.3167, :precision => 10, :scale => 7
      t.integer :user_id
      t.timestamps
    end
    add_index :houses, :user_id
  end
end
