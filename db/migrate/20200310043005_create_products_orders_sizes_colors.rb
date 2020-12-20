class CreateProductsOrdersSizesColors < ActiveRecord::Migration[5.2]
  def change
    create_table :products_orders_sizes_colors do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.references :size, foreign_key: true
      t.references :color, foreign_key: true
      t.timestamps
    end
  end
end
