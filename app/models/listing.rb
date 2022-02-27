class Listing < ApplicationRecord
  has_many :user_listings
  has_many :users, through: :user_listings

  validates_presence_of :year, :make, :model, :trim, :body, :transmission, :vin,
                        :state, :condition, :odometer, :color, :interior, :sellingprice
  validates_numericality_of :year, greater_than: 0, only_integer: true
  validates_numericality_of :condition, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  validates_numericality_of :odometer, greater_than: 0, only_integer: true
  validates_numericality_of :sellingprice, greater_than: 0, only_integer: true
end
