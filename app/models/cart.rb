class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :color
  belongs_to :size
  belongs_to :product
end
