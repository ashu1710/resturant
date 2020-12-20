class ChangeColumnDataTypeInBooking < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookings, :is_confirm, :string
  end
end
