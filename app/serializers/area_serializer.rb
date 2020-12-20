class AreaSerializer
    include FastJsonapi::ObjectSerializer
	attribute :id do |area|
		area.id
	end
	attribute :area_name do |area|
		area.name
	end
	attribute :city_id do |area|
		area.city.id
	end
	attribute :city_name do |area|
		area.city.name
	end
end
