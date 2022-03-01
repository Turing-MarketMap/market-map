require 'rails_helper'

RSpec.describe 'User Listings Endpoints', type: :request do
  before(:each) do

    @user = create(:user)

    4.times do
      listing = create(:listing)
      create(:user_listing, user: @user, listing: listing)
    end

    @user_listings = Listing.all

    @other_listings = create_list(:listing, 2)
  end

  it 'returns listings for a specific user' do
    get "http://localhost:3000/api/v1/users/#{@user.id}/listings"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(4)

    expect(json[:data][0][:id].to_i).to eq(@user_listings[0].id)
    expect(json[:data][1][:id].to_i).to eq(@user_listings[1].id)
    expect(json[:data][2][:id].to_i).to eq(@user_listings[2].id)
    expect(json[:data][3][:id].to_i).to eq(@user_listings[3].id)
  end

  describe 'sad path' do
    it 'deosnt return listings if user id is invalid' do
      get "http://localhost:3000/api/v1/users/invalid/listings"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:message)
      expect(json[:message]).to eq("Couldn't find User with 'id'=invalid")
      expect(response).to_not be_successful
    end
  end

  describe 'create a user listing' do 
    it 'successfully creates' do
      listing = create(:listing)
      user = create(:user)

      params = { listing_id: listing.id }
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_user_listings_path(user), headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(201)
      expect(parse_json[:message]).to eq("Saved listing for user.")
    end

    it 'fails to save' do 
      listing = create(:listing)
      user = create(:user)

      params = { listing_id: 0 }
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_user_listings_path(user), headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(404)
      expect(parse_json[:message]).to eq("Couldn't find Listing with 'id'=0")
    end
  end
end
