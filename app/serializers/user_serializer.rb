class UserSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id do |token|
    token.user.id
  end
  attribute :email do |token|
    token.user.email
  end
  attribute :mobile do |token|
    token.user.mobile
  end
  attribute :address do |token|
    token.user.address
  end

  attribute :is_vendor do |token|
    token.user.class.name == 'Admin'
  end
end
