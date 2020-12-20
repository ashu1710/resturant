class ColorSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id do |color|
	color.id
  end

  attribute :color_code do |color|
	color.color_code
  end 
end
