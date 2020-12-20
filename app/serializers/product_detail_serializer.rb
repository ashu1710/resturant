class ProductDetailSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id do |product|
    product.id
  end

  attribute :name do |product|
    product.name
  end

  attribute :price do |product|
    product.price
  end

  attribute :category_name do |product|
    product.category.try(:name)
  end

  attribute :sub_category_name do |product|
    product.sub_category.try(:name)
  end

  attribute :description do |product|
    product.description
  end

  attribute :image do |product|
    product.get_all_image_url
  end

  attribute :sizes do |product|
    SizeSerializer.new(product.sizes).serializable_hash[:data].map{ |data| data[:attributes]}
  end

  attribute :colors do |product|
    ColorSerializer.new(product.colors).serializable_hash[:data].map{ |data| data[:attributes]}
  end

  attribute :vendor_details do |product|
    AdminSerializer.new(product.admin).serializable_hash[:data][:attributes]
  end

end
