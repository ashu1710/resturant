class AddRemoveColumn < ActiveRecord::Migration[5.2]
  def change
  	remove_column :bookings, :admin_id
	remove_column :orders, :admin_id
	add_reference :bookings, :user, index: true
	add_reference :orders, :user, index: true
  end
end
