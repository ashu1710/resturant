class SubCategory < ApplicationRecord
	
  include Rails.application.routes.url_helpers
  belongs_to :category
  has_many :products, dependent: :destroy
  has_one_attached :sub_category_image

  def get_image_url
	url_for(self.sub_category_image)
  end
end
