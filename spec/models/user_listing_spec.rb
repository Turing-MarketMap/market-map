require 'rails_helper'

RSpec.describe UserListing do
  before(:each) do
    @user_listing = create(:user_listing)
  end

  it { should belong_to(:user) }
  it { should belong_to(:listing) }

  it 'exists' do
    expect(@user_listing).to be_a(UserListing)
  end

  it 'has attributes' do
    expect(@user_listing.id).to be_a(Integer)
    expect(@user_listing.user_id).to be_a(Integer)
    expect(@user_listing.listing_id).to be_a(Integer)
  end
end
