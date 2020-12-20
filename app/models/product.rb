class Product < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :bookings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  belongs_to :admin
  belongs_to :category
  has_many :products_orders_sizes_colors
  belongs_to :sub_category, optional: true
  has_and_belongs_to_many :sizes
  has_and_belongs_to_many :colors
  has_many_attached :images

    def get_image_url
      self.images.present? ? url_for(self.images.first) : '-'
    end

    def get_all_image_url
      all_images = []
      self.images.each do |image|
        all_images << url_for(image)
      end
      all_images
    end
end
