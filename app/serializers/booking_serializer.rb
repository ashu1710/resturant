class BookingSerializer
  	include FastJsonapi::ObjectSerializer
  	attribute :id do |booking|
		booking.id
	end
	attribute :booking_date do |booking|
		booking.booking_date
	end

	attribute :user_email do |booking|
		booking.user.email
	end

	attribute :user_mobile do |booking|
		booking.user.mobile
	end

	attribute :product_name do |booking|
		booking.product.name
	end

	attribute :product_price do |booking|
		booking.product.price
	end

	attributes :product_image do |order|
		order.product.get_image_url
  	end

  	attribute :is_confirmed do |booking|
		booking.is_confirmed.present?
	end

	
end
