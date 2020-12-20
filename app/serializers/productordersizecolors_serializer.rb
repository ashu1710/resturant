class ProductordersizecolorsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id do |poscs|
  	poscs.id
  end

  attributes :product_details do |poscs|
    ProductSerializer.new(poscs.product).serializable_hash[:data][:attributes]
  end

  attributes :size_details do |poscs|
    SizeSerializer.new(poscs.size).serializable_hash[:data][:attributes]
  end

  attributes :color_details do |poscs|
    ColorSerializer.new(poscs.color).serializable_hash[:data][:attributes]
  end

  attributes :order_details do |poscs|
    OrderSerializer.new(poscs.order).serializable_hash[:data][:attributes]
  end

end
