class AddColumnToAdminTypeAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :is_admin, :boolean, default: false
  end
end
