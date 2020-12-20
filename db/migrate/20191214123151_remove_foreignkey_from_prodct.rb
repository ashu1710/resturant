class RemoveForeignkeyFromProdct < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :user_id
  	add_reference :products, :admin, index: true
  end
end
