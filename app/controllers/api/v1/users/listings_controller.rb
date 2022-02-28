class Api::V1::Users::ListingsController < ApplicationController
  def index
    # binding.pry
    # binding.pry
    user = User.find(params[:user_id])

    json_response(ListingSerializer.new(user.listings))
  end
end
