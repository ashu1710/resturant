class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :email_confirmation, :login

	devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :validatable, :authentication_keys => [:login]

  
  has_one_attached :avatar
  has_many :auth_tokens
  has_many :products, dependent: :destroy
  belongs_to :city
  belongs_to :area


  def login=(login)
    @login = self.email
  end

  def login
    @login || self.mobile || self.email
  end

  def get_full_address
    "#{self.address}, #{self.try(:area).try(:name)}, #{self.city.try(:name)}"
  end

  def self.find_for_database_authentication warden_conditions
	  conditions = warden_conditions.dup
	  login = conditions.delete(:login)
	  where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
	end
end

