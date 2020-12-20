class AdminSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |admin|
    admin.id
  end

  attribute :mobile do |token|
    token.mobile || '-'
  end

  attribute :email do |token|
    token.email || '-'
  end


  attribute :address do |token|
    token.get_full_address
  end
end
