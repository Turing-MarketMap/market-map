require 'rails_helper'

RSpec.describe Listing do
  before(:each) do
    @listing = create(:listing)
  end

  it 'exists' do
    expect(@listing).to be_a(Listing)
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
end
