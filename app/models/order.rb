class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :products_orders_sizes_colors, dependent: :destroy
  has_and_belongs_to_many :products
  belongs_to :address

end
