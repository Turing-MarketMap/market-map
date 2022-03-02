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
