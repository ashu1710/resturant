class Area < ApplicationRecord
  has_many :admins, dependent: :destroy	
  belongs_to :city
end
