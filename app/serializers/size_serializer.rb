class SizeSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id do |size|
	size.id
  end
  
  attribute :size_no do |size|
	size.size_no
  end
end
