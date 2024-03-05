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

  scenario 'missing body' do
    visit new_post_path

    click_on 'Post'

    expect(page).to have_content('Validation failed')
  end

  scenario 'attach an image' do
    visit new_post_path

    fill_in 'post_body', with: 'This post has an image'

    attach_file 'post_images',
                '/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/fukuoka.jpg', make_visible: true

    click_on 'Post'

    expect(page).to have_css('.image')
  end
  scenario 'attach multiple images' do
    visit new_post_path

    fill_in 'post_body', with: 'This post has two images'

    attach_file 'post_images',
                ['/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/fukuoka.jpg', '/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/profile.jpg'], make_visible: true

    click_on 'Post'

    expect(page).to have_css('.image', count: 2)
  end
end
