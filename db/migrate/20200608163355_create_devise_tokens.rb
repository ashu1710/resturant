class CreateDeviseTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :devise_tokens do |t|
      t.text :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
