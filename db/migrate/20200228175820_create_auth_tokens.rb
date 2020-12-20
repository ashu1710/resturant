class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.references :user, polymorphic: true

      t.timestamps
    end
  end
end
