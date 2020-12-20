class AddColumnAddressToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :address, :text
  end
end
