require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'Accepts a valid user' do
    expect(user).to be_valid
  end
end
