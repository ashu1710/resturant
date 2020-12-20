class CitySerializer
  include FastJsonapi::ObjectSerializer
	attribute :id do |city|
		city.id
	end
	attribute :city_name do |city|
		city.name
	end
end
