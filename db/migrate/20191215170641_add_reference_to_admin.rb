class AddReferenceToAdmin < ActiveRecord::Migration[5.2]
  def change
	add_reference :admins, :city, index: true
	add_reference :admins, :area, index: true
  end
end
