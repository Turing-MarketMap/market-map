require 'rails_helper'

RSpec.describe 'Listings API', type: :request do
  describe '/listings/id' do
    context 'listing exists' do
      let!(:listing) { create(:listing) }
      it "gets a single listing by the id" do
        get "/api/v1/listings/#{listing.id}"
        json = parse_json
        data = json[:data]

        expect(response).to be_successful
        expect(data).to be_a(Hash)
        expect(data.keys).to eq([:id, :type, :attributes])
        expect(data[:attributes].keys).to eq([:year, :make, :model, :trim, :body, :transmission, :vin, :state, :condition, :odometer, :color, :interior, :sellingprice])
      end
    end
  end

  describe 'create new listing POST /api/vi/listings' do
    context 'good params' do
      describe 'create a listing' do
        it 'successfully creates' do
          user = create(:user)
          params = { user_id: user.id, year: 2022, make: 'Mazda', model: 'Mazda3', odometer: 20000, sellingprice: 18000  }
          headers = { 'CONTENT_TYPE' => 'application/json'}

          post api_v1_listings_path, headers: headers, params: JSON.generate(listing: params)

          new_listing = Listing.last

          expect(response.status).to eq(200)
          expect(new_listing.year).to eq(params[:year])
          expect(new_listing.make).to eq(params[:make])
          expect(new_listing.model).to eq(params[:model])
          expect(new_listing.odometer).to eq(params[:odometer])
          expect(new_listing.sellingprice).to eq(params[:sellingprice])

          new_user_listing = UserListing.last

          expect(new_user_listing.user_id).to eq(params[:user_id])
          expect(new_user_listing.listing_id).to eq(new_listing.id)
        end
      end
    end

    context 'bad params' do
      describe 'correct error response' do
        it 'has no params to create listing' do
          params = {}
          headers = { 'CONTENT_TYPE' => 'application/json'}

          post api_v1_listings_path, headers: headers, params: JSON.generate(listing: params)

          new_listing = Listing.last

          expect(response.status).to eq(422)
          expect(parse_json[:errors]).to eq("param is missing or the value is empty: listing")
        end

        it 'has some params to create listing' do
          params = { year: 2022, make: 'Mazda' }
          headers = { 'CONTENT_TYPE' => 'application/json'}

          post api_v1_listings_path, headers: headers, params: JSON.generate(listing: params)

          expect(response.status).to eq(422)
          expect(parse_json[:errors]).to eq("Model can't be blank, Odometer can't be blank, Odometer is not a number, Sellingprice can't be blank, and Sellingprice is not a number")
        end
      end
    end
  end

  describe 'edit listing PATCH /api/v1/listings/listing_id' do
    context 'listing exists' do
      it "updates the listing" do
        listing = create(:listing, year: 2022)
        params = { year: 2000}
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/listings/#{listing.id}", headers: headers, params: JSON.generate(listing: params)

        expect(response.status).to eq(200)
        expect(listing.reload.year).to eq(2000)
      end
    end
    context 'listings does not exist' do
      it "returns correct error message" do
        params = { year: 2000}
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/listings/10000000", headers: headers, params: JSON.generate(listing: params)

        expect(response.status).to eq(404)
        expect(parse_json[:message]).to eq("Couldn't find Listing with 'id'=10000000")
      end
    end

    context 'bad param titles' do
      it "returns correct error message" do
        listing = create(:listing, year: 2022)
        params = { yr: 2000}
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/listings/#{listing.id}", headers: headers, params: JSON.generate(listing: params)

        expect(response.status).to eq(422)
        expect(parse_json[:errors]).to eq("Parameters either incorrect or missing")
      end
    end

    context 'bad param values' do
      it "returns correct error message" do
        listing = create(:listing, year: 2022)
        params = { year: 'abc'}
        headers = { 'CONTENT_TYPE' => 'application/json'}

        patch "/api/v1/listings/#{listing.id}", headers: headers, params: JSON.generate(listing: params)

        expect(response.status).to eq(404)
        expect(parse_json[:errors]).to eq("Year is not a number")
      end
    end
  end

  describe '/listings/search' do
    it 'sends all the listings' do
      create_list(:listing, 10)
      get api_v1_listings_path

      json = parse_json
      data = json[:data]

      expect(response).to be_successful
      expect(data).to be_a(Array)
      expect(data.first.keys).to eq([:id, :type, :attributes])
      expect(data.first[:attributes].keys).to eq([:year, :make, :model, :trim, :body, :transmission, :vin, :state, :condition, :odometer, :color, :interior, :sellingprice])
    end

    it 'can search listings by params - return one car' do
      @listing_1 = create(:listing, year: 2001, make: "Toyota", model: "Camry")
      @listing_2 = create(:listing, year: 2002, make: "Toyota", model: "4Runner")
      @listing_3 = create(:listing, year: 2003, make: "Toyota", model: "Tundra")
      @listing_4 = create(:listing, year: 2004, make: "Chevrolet", model: "Suburban")
      @listing_5 = create(:listing, year: 2005, make: "Chevrolet", model: "Silverado")
      @listing_6 = create(:listing, year: 2006, make: "Ford", model: "F-150")
      @listing_7 = create(:listing, year: 2007, make: "Ford", model: "F-150")
      @listing_8 = create(:listing, year: 2008, make: "Ford", model: "Focus")
      @listing_9 = create(:listing, year: 2009, make: "Ford", model: "Escape")
      @listing_10 = create(:listing, year: 2010, make: "Ford", model: "Escape")

      get api_v1_listings_search_path(search_params: {min_year: 2001, max_year: 2004, make: "Toyota", model: "Camry"})

      json = parse_json
      data = json[:data]

      expect(response).to be_successful
      expect(data).to be_a(Array)
      expect(data.first.keys).to eq([:id, :type, :attributes])
      expect(data.first[:attributes].keys).to eq([:year, :make, :model, :trim, :body, :transmission, :vin, :state, :condition, :odometer, :color, :interior, :sellingprice])
      expect(data.count).to eq(1)
      expect(data.first[:attributes][:make]).to eq("Toyota")
      expect(data.first[:attributes][:model]).to eq("Camry")
      expect(data.first[:attributes][:year]).to eq(2001)
    end

    it 'can search listings by params - return one car' do
      @listing_1 = create(:listing, year: 2001, make: "Toyota", model: "Camry")
      @listing_2 = create(:listing, year: 2002, make: "Toyota", model: "4Runner")
      @listing_3 = create(:listing, year: 2003, make: "Toyota", model: "Tundra")
      @listing_4 = create(:listing, year: 2004, make: "Chevrolet", model: "Suburban")
      @listing_5 = create(:listing, year: 2005, make: "Chevrolet", model: "Silverado")
      @listing_6 = create(:listing, year: 2006, make: "Ford", model: "F-150")
      @listing_7 = create(:listing, year: 2007, make: "Ford", model: "F-150")
      @listing_8 = create(:listing, year: 2008, make: "Ford", model: "Focus")
      @listing_9 = create(:listing, year: 2009, make: "Ford", model: "Escape")
      @listing_10 = create(:listing, year: 2010, make: "Ford", model: "Escape")

      get api_v1_listings_search_path(search_params: {min_year: 2001, max_year: 2004, make: "Toyota", model: "Camry"})

      json = parse_json
      data = json[:data]

      expect(response).to be_successful
      expect(data).to be_a(Array)
      expect(data.first.keys).to eq([:id, :type, :attributes])
      expect(data.first[:attributes].keys).to eq([:year, :make, :model, :trim, :body, :transmission, :vin, :state, :condition, :odometer, :color, :interior, :sellingprice])
      expect(data.count).to eq(1)
      expect(data.first[:attributes][:make]).to eq("Toyota")
      expect(data.first[:attributes][:model]).to eq("Camry")
      expect(data.first[:attributes][:year]).to eq(2001)
    end

    it 'can search listings by params - no matching cars' do
      @listing_1 = create(:listing, year: 2001, make: "Toyota", model: "Camry")
      @listing_2 = create(:listing, year: 2002, make: "Toyota", model: "4Runner")
      @listing_3 = create(:listing, year: 2003, make: "Toyota", model: "Tundra")
      @listing_4 = create(:listing, year: 2004, make: "Chevrolet", model: "Suburban")
      @listing_5 = create(:listing, year: 2005, make: "Chevrolet", model: "Silverado")
      @listing_6 = create(:listing, year: 2006, make: "Ford", model: "F-150")
      @listing_7 = create(:listing, year: 2007, make: "Ford", model: "F-150")
      @listing_8 = create(:listing, year: 2008, make: "Ford", model: "Focus")
      @listing_9 = create(:listing, year: 2009, make: "Ford", model: "Escape")
      @listing_10 = create(:listing, year: 2010, make: "Ford", model: "Escape")

      get api_v1_listings_search_path(search_params: {min_year: 2001, max_year: 2004, make: "Honda", model: "Camry"})

      json = parse_json
      data = json[:data]

      expect(response).to be_successful
      expect(data).to be_a(Array)
      expect(data.count).to eq(0)
    end
  end
end
