class AddAdressToHouse < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :adress, :string
  end
end
