class AddColumninAddress < ActiveRecord::Migration[5.2]
  def change
  	add_column :addresses, :city_name, :string
  	add_column :addresses, :area_name, :string
  	remove_column :addresses, :area_id
  	remove_column :addresses, :city_id
  end
end
