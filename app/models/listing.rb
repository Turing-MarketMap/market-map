class Listing < ApplicationRecord
  has_many :user_listings
  has_many :users, through: :user_listings

  validates_presence_of :year, :make, :model, :odometer, :sellingprice
  validates_numericality_of :year, greater_than: 0, only_integer: true
  validates_numericality_of :odometer, greater_than_or_equal_to: 0, only_integer: true
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


  # def self.super_scope(min_year=nil, max_year=nil, make=nil, model=nil)
  #   # filters = [min_year, max_year, make, model]
  #   # binding.pry
  #   # parameters_filter = filters[0].map do |p|
  #   #   p =! nil
  #   # end
  #
  #   Listing.scope_filter_by_year(min_year, max_year).scope_filter_by_make(make).scope_filter_by_model(model).unscope(where: make, model)
  # end

  def self.filter_by_year(min_year, max_year)
    Listing.where(year: min_year..max_year)
  end

  def self.filter_by_make(make)
    Listing.where(make: make)
  end

  def self.filter_by_model(model)
    Listing.where(model: model)
  end

  def self.filter_by_year_make_model(search_params)
    Listing.where(year: search_params[:min_year]..search_params[:max_year], make: search_params[:make], model: search_params[:model])
  end
end
