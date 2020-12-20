class SubCategorySerializer
  include FastJsonapi::ObjectSerializer
  	attribute :id do |sub_category|
		sub_category.id
	end
	attribute :sub_category_name do |sub_category|
		sub_category.name
	end

	attribute :image do |category|
		category.get_image_url
	end

	attribute :category_id do |sub_category|
		sub_category.category.id
	end
	attribute :category_name do |sub_category|
		sub_category.category.name
	end 
end
