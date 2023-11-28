class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_one_attached :avatar
  has_many :likes
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'

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
