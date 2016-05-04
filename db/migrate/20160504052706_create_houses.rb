class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :description, default: ""
      t.decimal :price, default: 0.0
      t.boolean :published, default: false
      t.decimal :latitude, default: 25.6667
      t.decimal :longitude, default: -100.3167
      t.integer :user_id
      t.timestamps
    end
    add_index :houses, :user_id
  end
end
