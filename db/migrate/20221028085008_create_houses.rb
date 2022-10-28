class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :image_data
      t.string :description
      t.string :price
      t.timestamps
    end
  end
end
