require 'rails_helper'

RSpec.describe User do
  before(:each) do
    @user = create(:user)
  end

  it 'exists' do
    expect(@user).to be_a(User)
  end

  describe 'relationships' do
    it { should have_many(:user_listings) }
    it { should have_many(:listings).through(:user_listings) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
  end
end
