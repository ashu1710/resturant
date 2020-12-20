class Banner < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :banner_image

  def get_image_url
    url_for(self.banner_image)
  end

end
