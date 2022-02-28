class Api::V1::ListingsController < ApplicationController 
  def index 
    # binding.pry
    json_response(ListingSerializer.new(Listing.all))
  end
end