class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	attr_accessor :email_confirmation, :login
	devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :validatable, :authentication_keys => [:login]

	has_many :booking, dependent: :destroy
	has_many :order, dependent: :destroy
	has_many :devise_tokens, dependent: :destroy
	has_many :carts, dependent: :destroy
	has_many :address, dependent: :destroy
	has_many :auth_tokens, dependent: :destroy
	has_many :products_orders_sizes_colors, dependent: :destroy

	def login=(login)
		@login = self.email
	end

	def login
		@login || self.mobile || self.email
	end

  	def self.find_for_database_authentication warden_conditions
		conditions = warden_conditions.dup
		login = conditions.delete(:login)
		where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
	end

end
