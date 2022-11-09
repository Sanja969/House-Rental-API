class RemoveCityFromReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :city, :string
  end
end
