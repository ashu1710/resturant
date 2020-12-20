class AddColorSizeCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :color, foreign_key: true
    add_reference :carts, :size, foreign_key: true
  end
end
