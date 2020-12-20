class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :is_confirmed, :boolean
  	remove_column :orders, :is_confirm
  end
end
