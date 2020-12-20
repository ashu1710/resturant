class Category < ApplicationRecord
    include Rails.application.routes.url_helpers
	has_many :sub_category, dependent: :destroy
  	has_one_attached :category_image

  	def get_image_url
    	url_for(self.category_image)
  	end

end
