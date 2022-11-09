class AddAvailableToHouse < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :available, :boolean
  end
end
