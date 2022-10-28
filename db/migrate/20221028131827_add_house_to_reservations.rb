class AddHouseToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :house, null: false, foreign_key: {to_table: :houses}
  end
end
