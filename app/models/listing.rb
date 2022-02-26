class Listing < ApplicationRecord
  def self.filter_by_year(min_year, max_year)
    filtered = Listing.where(year: min_year..max_year)
  end

  def self.filter_by_make(make)
    filtered = Listing.where(make: make)
  end

  def self.filter_by_model(model)
    filtered = Listing.where(model: model)
  end



end
