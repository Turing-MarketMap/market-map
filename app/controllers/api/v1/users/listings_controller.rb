class Api::V1::Users::ListingsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    json_response(ListingSerializer.new(user.listings))
  end

  def create 
    binding.pry
  end
end
