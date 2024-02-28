require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  before(:each) do
    @user = User.new
  end

  it 'Accepts a valid user' do
    expect(user).to be_valid
  end

  it 'doesn\'t accept a user without a name' do
    @user.email = 'test@test.com'

    expect(@user.save).to be_falsey
  end
end
