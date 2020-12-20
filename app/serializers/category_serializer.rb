class CategorySerializer
  include FastJsonapi::ObjectSerializer
  	attribute :id do |category|
		category.id
	end
  
	attribute :name do |category|
		category.name
	end

	attribute :image do |category|
		category.get_image_url
	end

	attribute :is_sub_category do |category|
		category.category_type == 'buying'
	end
	
end
