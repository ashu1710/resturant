class SessionSerializer
  include FastJsonapi::ObjectSerializer
  attribute :token do |auth_token|
    auth_token.token
  end
  attribute :user do |token|
    UserSerializer.new(token).serializable_hash[:data][:attributes]
  end
end
