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

  def create
    listing = Listing.create(new_params)
    if listing.id
      UserListing.create(user_id: params[:listing][:user_id], listing_id: listing.id)
      json_response(ListingSerializer.new(Listing.last))
    else
      json_response({errors: listing.errors.full_messages.to_sentence}, :unprocessable_entity)
    end
  end

  def update
    listing = Listing.find(params[:id])

    if new_params == {}
      json_response({errors: "Parameters either incorrect or missing"}, :unprocessable_entity)
    elsif listing.update(new_params)
      json_response(ListingSerializer.new(listing))
    else
      json_response({errors: listing.errors.full_messages.to_sentence}, :not_found)
    end
  end

  private

  def search_params
    params.require(:search_params).permit(:min_year, :max_year, :make, :model)
  end

  def new_params
    params.require(:listing).permit(:year, :make, :model, :trim, :body, :transmission, :vin, :state, :condition, :odometer, :color, :interior, :sellingprice)
  end
end
