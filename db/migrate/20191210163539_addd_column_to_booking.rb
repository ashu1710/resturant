class AdddColumnToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :is_done, :boolean, default: false
  end
end
