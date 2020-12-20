class BannerSerializer
  include FastJsonapi::ObjectSerializer
  	attribute :id do |banner|
		banner.id
	end
	attribute :image do |banner|
		banner.get_image_url
	end
	attribute :product_id do |banner|

		banner.product_link_redirect.present? ? banner.product_link_redirect.split("/").last(2).try(:first) : '-'
	end

	attribute :is_booking do |banner|
		is_booking = '-'
		if banner.product_link_redirect.present? 
			product_id = banner.product_link_redirect.split("/").last(2).try(:first)
			product = Product.find_by id: product_id
			is_booking = product.present? ? product.category.category_type == 'booking' : '-'
		end
		is_booking
	end


end
