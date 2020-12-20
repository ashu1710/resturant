class ProductsSize < ActiveRecord::Migration[5.2]
  def change
  	create_table :products_sizes, :id => false do |t|
		t.integer :product_id
		t.integer :size_id
    end
  end
end
