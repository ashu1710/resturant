class RemoveColumnFromBookingOrder < ActiveRecord::Migration[5.2]
  def change
  		remove_column :bookings, :user_id
  		remove_column :orders, :user_id
  		add_reference :bookings, :admin, index: true
  		add_reference :orders, :admin, index: true
  end
end
