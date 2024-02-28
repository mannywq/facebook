require 'rails_helper'

RSpec.describe 'Create a post', type: :system do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario 'valid input' do
    visit new_post_path

    fill_in 'post_body', with: 'This is a test post'

    click_on 'Post'

    expect(page).to have_current_path(user_path(@user.id))
  end
end
