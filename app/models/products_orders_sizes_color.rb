class ProductsOrdersSizesColor < ApplicationRecord
	belongs_to :order
	belongs_to :color
	belongs_to :size
	belongs_to :user
	belongs_to :product
end
