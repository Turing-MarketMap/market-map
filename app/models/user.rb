class User < ApplicationRecord 
  has_many :user_listings
  has_many :listings, through: :user_listings

  validates_presence_of :first_name, :last_name, :email
  validates :email, email: true, uniqueness: true
end