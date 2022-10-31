class ChangePriceToBeNumericInHouuses < ActiveRecord::Migration[7.0]
  def change
    change_column :houses, :price, :decimal, using: 'price::integer'
  end
end
