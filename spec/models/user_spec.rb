require 'rails_helper'

RSpec.describe User do
  before(:each) do
    @user = create(:user)
  end

  it 'exists' do
    expect(@user).to be_a(User)
  end

  it 'has attributes' do
    expect(@user.id).to be_a(Integer)
    expect(@user.email).to be_a(String)
    expect(@user.first_name).to be_a(String)
    expect(@user.last_name).to be_a(String)
  end
end
