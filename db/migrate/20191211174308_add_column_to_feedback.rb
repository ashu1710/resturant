class AddColumnToFeedback < ActiveRecord::Migration[5.2]
  def change
  	add_column :feedbacks, :is_confirmed, :boolean, default: false
  end
end
