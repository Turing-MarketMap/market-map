class Listing < ApplicationRecord
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
