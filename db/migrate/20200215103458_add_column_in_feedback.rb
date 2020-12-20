class AddColumnInFeedback < ActiveRecord::Migration[5.2]
  def change
  	remove_column :feedbacks, :user_id
    add_column :feedbacks, :first_name, :string
    add_column :feedbacks, :last_name, :string
    add_column :feedbacks, :mobile, :string
    add_column :feedbacks, :email, :string
  end
end
