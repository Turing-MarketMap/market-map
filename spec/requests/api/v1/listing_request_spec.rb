require 'rails_helper'

RSpec.describe 'Listings API', type: :request do 
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
end