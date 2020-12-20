class AddColumnToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :mobile, :string
  end
end
