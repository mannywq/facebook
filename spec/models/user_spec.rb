# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'Attachments' do
    it { should have_one_attached :avatar }
    it { should have_one_attached :header_photo }
  end
  describe 'Associations' do
    it { should have_many :friends }
    it { should have_many :friendships }
    it { should have_many :likes }
    it { should have_many :comments }
  end

  describe 'Attachments and images' do
    let(:user) { create(:user) }
    context 'when a profile pic is added' do
      file = File.open('/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/profile.jpg')

      it 'should be attached to the user' do
        user.avatar.attach(io: file, filename: 'face.jpg')

        expect(user.avatar).to be_attached
      end
    end
    context 'when a header photo is added' do
      file = File.open('/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/default-header.jpg')

      it 'Should save a header photo attachment' do
        user.header_photo.attach(io: file, filename: 'header.jpg')

        expect(user.header_photo).to be_attached
      end
    end
    context 'when an invalid file type is added' do
      file = File.open('/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/returns.pdf')
      it 'should fail validation' do
        user.avatar.attach(io: file, filename: 'returns.pdf')

        puts user.errors.full_messages
        expect(user).not_to be_valid
      end
    end
  end

  describe 'Email notifications' do
    context 'when a user is created' do
      it 'should send a welcome email' do
        expect(UserMailer).to receive(:welcome_email).with(an_instance_of(User)).and_call_original

        user = create(:user)
      end
    end
  end

  describe '#incoming_friend_requests' do
    let(:friend) { create(:user) }
    let(:user) { create(:user) }
    context 'When a friend request is received' do
      it 'returns incoming pending friend requests' do
        create(:friendship, friend: user, user: friend, status: 'pending')
        requests = user.incoming_friend_requests

        expect(requests).not_to be_empty
      end
    end
  end

  describe '#sent_requests' do
    let(:friend) { create(:user) }
    let(:user) { create(:user) }

    context 'When a friend request is sent' do
      it 'returns sent pending friend requests' do
        create(:friendship, friend:, user:, status: 'pending')

        requests = user.sent_requests

        expect(requests).not_to be_empty
      end
    end
  end
  describe '#friends' do
    let(:user) { create(:user) }
    context 'When a user has multiple friends' do
      it 'returns a list of the user\'s friends' do
        friend1 = create(:user)
        friend2 = create(:user)

        create(:friendship, user:, friend: friend1, status: 'active')
        create(:friendship, user:, friend: friend2, status: 'active')

        expect(user.friends.length).to eq(2)
      end
    end
    context 'When a user has one friend' do
      it 'returns the friend' do
        user = create(:user)
        friend1 = create(:user)
        create(:friendship, user:, friend: friend1, status: 'active')
        expect(user.friends).not_to be_empty
      end
    end
    context 'When a user has no friends' do
      it 'returns an empty array' do
        expect(user.friends).to be_empty
      end
    end
  end

  describe '#friends?' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    context 'When two users are friends' do
      it 'returns true' do
        create(:friendship, user:, friend:, status: 'active')

        expect(user.friends?(friend)).to be_truthy
      end
    end
    context 'When two users are not friends' do
      it 'returns false' do
        expect(user.friends?(friend)).to be_falsey
      end
    end
  end

  describe '#friends_with_status' do
    let(:user) { create(:user) }
    context 'When there\'s more than one friend' do
      it 'returns a list of friends with status' do
        friend1 = create(:user)
        friend2 = create(:user)

        create(:friendship, user:, friend: friend1, status: 'pending')
        create(:friendship, user:, friend: friend2, status: 'pending')

        res = user.friends_with_status('pending')

        expect(res.length).to eq(2)
      end
    end
    context 'When there is only one friend' do
      it 'returns the friend' do
        friend1 = create(:user)
        create(:friendship, user:, friend: friend1, status: 'pending')

        res = user.friends_with_status(:pending)

        expect(res).not_to be_empty
      end
    end
  end

  describe '#add_friend' do
    let(:user) { create(:user) }
    context 'When there is no relationship' do
      it 'adds a friend' do
        friend = create(:user)
        expect(user.add_friend(friend.id)).to be_truthy
      end
    end
    context 'When there is an existing relationship' do
      it 'does not add a friend' do
        friend = create(:user)
        create(:friendship, user:, friend:, status: 'pending')

        expect(user.add_friend(friend.id)).to be_falsey
      end
    end
  end
end
