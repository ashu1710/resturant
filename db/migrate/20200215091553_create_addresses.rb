class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.text :street_1
      t.references :city, foreign_key: true
      t.references :area, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
