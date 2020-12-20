class AddColumnInBanner < ActiveRecord::Migration[5.2]
  def change
  	add_column :banners, :product_link_redirect, :string
  end
end
