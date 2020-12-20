class ChnageColumnType < ActiveRecord::Migration[5.2]
  def change
  	add_column :bookings, :is_confirmed, :boolean
  	remove_column :bookings, :is_confirm
  end
end
