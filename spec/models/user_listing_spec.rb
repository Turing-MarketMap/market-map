require 'rails_helper'

RSpec.describe UserListing do
  before(:each) do
    @user_listing = create(:user_listing)
  end
  
  it 'exists' do
    expect(@user_listing).to be_a(UserListing)
  end

  describe 'relationships' do
    it { should belong_to(:listing) }
    it { should belong_to(:user) }
  end
end
