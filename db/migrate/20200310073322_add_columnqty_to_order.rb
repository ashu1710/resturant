class AddColumnqtyToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :products_orders_sizes_colors, :qty, :integer, default: 1
    add_reference :products_orders_sizes_colors, :user, foreign_key: true
  end
end
