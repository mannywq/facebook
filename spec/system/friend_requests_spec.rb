require 'rails_helper'

RSpec.describe 'Friend requests', type: :system do
  before do
    @user = create(:user)

    @friend = create(:user)
    login_as(@user)
  end

  scenario 'Shows new friend requests' do
    @friend.add_friend(@user.id)

    visit notifications_path

    expect(page).to have_text('Accept invite')
  end

  scenario 'Accepted friend request shows confirmation' do
    @friend.add_friend(@user.id)

    visit notifications_path

    click_on 'Accept invite'

    expect(page).to have_text('Added new friend')
  end
  scenario 'Showing a list of current friends' do
    friends = create_list(:user, 5)

    friends.each do |afriend|
      create(:friendship, user: @user, friend: afriend, status: 'active')
    end

    visit users_path

    expect(page).to have_button('Unfriend', count: 5)
  end
  scenario 'Show a list of friends to discover' do
    visit users_path

    click_on 'Discover'

    expect(page).to have_css('.name', minimum: 2)
  end
  scenario 'Unfriending an existing friend' do
    create(:friendship, user: @user, friend: @friend, status: 'active')

    visit users_path

    click_on 'Unfriend'

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Add friend')
  end
end
