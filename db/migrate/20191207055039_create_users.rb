class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.integer :user_type
      t.date :dob

      t.timestamps
    end
  end
end
