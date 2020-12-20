class AddColumnToVendor < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :is_approved, :boolean, default: false  	
  end
end
