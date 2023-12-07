# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :avatar
  has_one_attached :header_photo
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def pending_friend_requests
    Friendship.where(friend_id: id, status: 'pending').map(&:user)
  end

  def grab_avatar_url
    url = URI.parse('https://randomuser.me/api/?inc=picture')
    response = Net::HTTP.get_response(url)
    data = JSON.parse(response.body)

    data['results'][0]['picture']['large']
  end

  def grab_avatar_image
    img = URI.parse(grab_avatar_url).open
    avatar.attach(io: img, filename: "user_#{id}")
  end
end
