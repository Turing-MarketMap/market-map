require 'rails_helper'

RSpec.describe Listing do
  before(:each) do
    @listing = create(:listing)
  end

  it 'exists' do
    expect(@listing).to be_a(Listing)
  end

  it 'has attributes' do
    expect(@listing.id).to be_a(Integer)
    expect(@listing.year).to be_a(Integer)
    expect(@listing.make).to be_a(String)
    expect(@listing.model).to be_a(String)
    expect(@listing.trim).to be_a(String)
    expect(@listing.body).to be_a(String)
    expect(@listing.transmission).to be_a(String)
    expect(@listing.vin).to be_a(String)
    expect(@listing.state).to be_a(String)
    expect(@listing.condition).to be_a(String)
    expect(@listing.odometer).to be_a(Integer)
    expect(@listing.color).to be_a(String)
    expect(@listing.interior).to be_a(String)
    expect(@listing.sellingprice).to be_a(Integer)
  end
end
