class AddColumnfirstProductToProduct < ActiveRecord::Migration[5.2]
  def change
  	remove_column :admins, :is_approved
    add_column :admins, :is_first_product, :boolean, default: false  	
  end
end
