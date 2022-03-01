class Api::V1::Users::ListingsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    json_response(ListingSerializer.new(user.listings))
  end

  def create 
    user = User.find(params[:user_id])
    listing = Listing.find(params[:listing_id])
    ul = UserListing.create(user: user, listing: listing)

    if ul.valid?
      render json: {message: 'Saved listing for user.'}, status: :created
    else
      json_response(ul.errors, :unprocessable_entity)
    end
  end

  def destroy 
    ul = UserListing.find_by(user: params[:user_id], listing: params[:id])
    ul.destroy
  end
end
