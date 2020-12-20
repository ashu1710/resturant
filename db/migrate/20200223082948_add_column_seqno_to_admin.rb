class AddColumnSeqnoToAdmin < ActiveRecord::Migration[5.2]
  def change
  	add_column :admins, :seq_no, :string
  end
end
