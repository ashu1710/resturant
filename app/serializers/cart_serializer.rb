class CartSerializer
 	include FastJsonapi::ObjectSerializer
    attribute :id do |cart|
    	cart.id
  	end

  	attribute :product_name do |cart|
    	cart.product.name
  	end

  	attribute :product_price do |cart|
    	cart.product.price
  	end

  	attribute :product_image do |cart|
    	cart.product.get_image_url
  	end

  	attribute :qty do |cart|
    	cart.qty
  	end

  	attribute :size_no do |cart|
    	cart.size.size_no
  	end

  	attribute :color_code do |cart|
    	cart.color.color_code
  	end

end
