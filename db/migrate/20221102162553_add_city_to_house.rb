class AddCityToHouse < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :city, :string
  end
end
