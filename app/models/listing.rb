class Listing < ApplicationRecord

  def self.get_makes
    Listing.all.distinct(:make).pluck(:make)
  end

  def self.get_make_models_hash

  end

  def self.get_models(make)
    
  end
end
