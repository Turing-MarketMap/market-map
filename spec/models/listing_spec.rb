require 'rails_helper'

RSpec.describe Listing do
  before(:each) do
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
  end

  describe 'relationships' do
    it { should have_many(:user_listings) }
    it { should have_many(:users).through(:user_listings) }
  end

  describe 'validations' do
    it { should validate_presence_of :year }
    it { should validate_numericality_of(:year).only_integer.is_greater_than(0) }
    it { should validate_presence_of :make }
    it { should validate_presence_of :model }
    it { should validate_presence_of :trim }
    it { should validate_presence_of :body }
    it { should validate_presence_of :transmission }
    it { should validate_presence_of :vin }
    it { should validate_presence_of :state }
    it { should validate_presence_of :condition }
    it { should validate_numericality_of(:condition).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:condition).is_less_than_or_equal_to(5) }
    it { should validate_presence_of :odometer }
    it { should validate_numericality_of(:odometer).only_integer.is_greater_than(0) }
    it { should validate_presence_of :color }
    it { should validate_presence_of :interior }
    it { should validate_presence_of :sellingprice }
    it { should validate_numericality_of(:sellingprice).only_integer.is_greater_than(0) }
  end

  it 'exists' do
    expect(@listing_1).to be_a(Listing)
  end

  it 'has attributes' do
    expect(@listing_1.id).to be_a(Integer)
    expect(@listing_1.year).to be_a(Integer)
    expect(@listing_1.make).to be_a(String)
    expect(@listing_1.model).to be_a(String)
    expect(@listing_1.trim).to be_a(String)
    expect(@listing_1.body).to be_a(String)
    expect(@listing_1.transmission).to be_a(String)
    expect(@listing_1.vin).to be_a(String)
    expect(@listing_1.state).to be_a(String)
    expect(@listing_1.condition).to be_a(Float)
    expect(@listing_1.odometer).to be_a(Integer)
    expect(@listing_1.color).to be_a(String)
    expect(@listing_1.interior).to be_a(String)
    expect(@listing_1.sellingprice).to be_a(Integer)
  end

  it 'can filter by year' do
    filtered_1 = Listing.filter_by_year(2003,2006)
    expect(filtered_1.count).to eq(4)

    filtered_2 = Listing.filter_by_year(2002,2002)
    expect(filtered_2.count).to eq(1)
  end

  it 'can filter by make' do
    fords = Listing.filter_by_make("Ford")
    expect(fords.count).to eq(5)

    chevrolets = Listing.filter_by_make("Chevrolet")
    expect(chevrolets.count).to eq(2)
  end

  it 'can filter by model' do
    f150s = Listing.filter_by_model("F-150")
    expect(f150s.count).to eq(2)

    camrys = Listing.filter_by_model("Camry")
    expect(camrys.count).to eq(1)
  end

  it 'can filter by year, make, model' do
    search_params = Hash.new()
    search_params[:min_year] = 2001
    search_params[:max_year] = 2004
    search_params[:make] = "Toyota"
    search_params[:model] = "Camry"

    camry = Listing.filter_by_year_make_model(search_params)
    expect(camry.count).to eq(1)
  end

  it 'can use scope to filter by year' do
    filtered_1 = Listing.scope_filter_by_year(2003,2006)
    expect(filtered_1.count).to eq(4)

    filtered_2 = Listing.filter_by_year(2002,2002)
    expect(filtered_2.count).to eq(1)
  end

  it 'can use scope to filter by make' do
    fords = Listing.scope_filter_by_make("Ford")
    expect(fords.count).to eq(5)
  end

  it 'can use scope to filter by model' do
    f150s = Listing.scope_filter_by_model("F-150")
    expect(f150s.count).to eq(2)

    camrys = Listing.filter_by_model("Camry")
    expect(camrys.count).to eq(1)
  end

  it 'can chain scopes - all params are included' do
    camry = Listing.scope_filter_by_year(2001,2001).scope_filter_by_make("Toyota").scope_filter_by_model("Camry")
    expect(camry.count).to eq(1)
  end

  # it 'can only use completed parameters' do
  #   filtered = Listing.super_scope(min_year: 2003, max_year: 2006)
  #   expect(filtered.count).to eq(4)
  # end
end
