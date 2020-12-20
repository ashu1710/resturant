class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id do |order|
  	order.id
  end

  attributes :user_email do |order|
  	order.user.email
  end


  attributes :user_mobile do |order|
  	order.user.mobile
  end


  attributes :product_name do |order|
  	order.product.name
  end

  attributes :product_image do |order|
	order.product.get_image_url
  end


  attributes :product_price do |order|
  	order.product.price
  end

  attributes :is_confirmed do |order|
    order.class.name == 'Order' ? order.is_confirmed.present? : order.order.is_confirmed.present? 
  end

  attributes :user_address do |order|
  	"#{order.try(:order).try(:address).try(:street_1)}, #{order.try(:order).try(:address).try(:area_name)} ,#{order.try(:order).try(:address).try(:city_name)} "
  end
end
