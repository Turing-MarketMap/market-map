class Api::V1::ListingsController < ApplicationController
  def index #(min_year, max_year, make, model)
    json_response(ListingSerializer.new(Listing.all))
  end

  def search
    listings = json_response(ListingSerializer.new(Listing.filter_by_year_make_model(search_params)))
    listings_parsed = JSON.parse(listings, symbolize_names: true)
    if listings_parsed[:data].count == 0
      ErrorsSerializer
    else
      listings
    end
  end

  def show
    json_response(ListingSerializer.new(Listing.find(params[:id])))
  end

  private

  def search_params
    params.require(:search_params).permit(:min_year, :max_year, :make, :model)
  end
end
