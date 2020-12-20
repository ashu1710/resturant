class ProductSerializer
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
    product.get_image_url
  end

  attribute :city_name do |product|
    product.try(:admin).try(:city).try(:name) || '-'
  end

  attribute :area_name do |product|
    product.try(:admin).try(:area).try(:name) || '-'
  end

end
