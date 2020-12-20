class AuthToken < ApplicationRecord
  belongs_to :user, polymorphic: true
end
