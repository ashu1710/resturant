class Size < ApplicationRecord
	has_and_belongs_to_many :products
    has_many :products_orders_sizes_colors, dependent: :destroy
	has_many :carts, dependent: :destroy
end
