class Listing < ApplicationRecord
  has_many :user_listings
  has_many :users, through: :user_listings

  validates_presence_of :year, :make, :model, :trim, :body, :transmission, :vin,
                        :state, :condition, :odometer, :color, :interior, :sellingprice
  validates_numericality_of :year, greater_than: 0, only_integer: true
  validates_numericality_of :condition, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  validates_numericality_of :odometer, greater_than: 0, only_integer: true
  validates_numericality_of :sellingprice, greater_than: 0, only_integer: true

  scope :scope_filter_by_year, ->(min_year, max_year) {
    where(year: min_year..max_year)
  }

  scope :scope_filter_by_make, ->(make) {
    where(make: make)
  }

  scope :scope_filter_by_model, ->(model) {
    where(model: model)
  }

  def self.filter_by_year(min_year, max_year)
    Listing.where(year: min_year..max_year)
  end

  def self.filter_by_make(make)
    Listing.where(make: make)
  end

  def self.filter_by_model(model)
    Listing.where(model: model)
  end

  def self.filter_by_year_make_model(min_year, max_year, make, model)
    Listing.where(year: min_year..max_year, make: make, model: model)
  end
end
