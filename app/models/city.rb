class City < ApplicationRecord
  	has_many :admins, dependent: :destroy
	has_many :areas, dependent: :destroy
end
