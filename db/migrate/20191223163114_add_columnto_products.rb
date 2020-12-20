class AddColumntoProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :is_first_product, :boolean, default: false  	
    add_column :products, :is_first_product, :boolean, default: false  	
  end
end
