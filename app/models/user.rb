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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_one_attached :avatar do |at|
    at.variant :thumb, resize_to_limit: [300, 300], saver: { quality: 80 }
    at.variant :large, resize_to_limit: [1500, 1500], saver: { quality: 80 }
  end
  has_one_attached :header_photo do |at|
    at.variant :thumb, resize_to_limit: [300, 300], saver: { quality: 80 }
    at.variant :large, resize_to_limit: [1500, 1500], saver: { quality: 80 }
  end
  validates :name, presence: true
  validates :email, presence: true
  validate :valid_image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  before_save :process_images
  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def valid_image
    acceptable = ['image/jpeg', 'image/png']
    return unless avatar.attached?

    unless acceptable.include?(avatar.content_type)
      errors.add(:avatar,
                 "Content type not accepted: #{avatar.content_type}")
      return
    end
    return unless header_photo.attached?

    return if acceptable.include?(header_photo.content_type)

    errors.add(:header_photo, "Content type not accepted: #{header_photo.content_type}")
  end

  def process_images
    # To be implemented
  end

  def incoming_friend_requests
    Friendship.pending_requests(id) # Our user is the friend in this scope
  end

  def sent_requests
    Friendship.where(user_id: id, status: :pending)
  end

  def friends?(friend)
    # puts "My id is #{id}"
    # puts "Friend id is #{friend}"
    Friendship.where(user_id: id,
                     friend_id: friend).or(Friendship.where(
                                             friend_id: id, user_id: friend
                                           )).exists?
  end

  def friends
    Friendship.where(user_id: id).or(Friendship.where(friend_id: id))
  end

  def friends_with_status(state)
    list = friends.where(status: state).map(&:user)
    list += friends.where(status: state).map(&:friend)
    list.uniq!
    list.reject! { |f| f.id == id }
    list
  end

  def add_friend(friend_id)
    friendship = Friendship.friends_with(id, friend_id)

    return false unless friendship.empty?

    Friendship.create!(user_id: id, friend_id:, status: :pending)
    true
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.avatar = auth.info.image
    end
  end

  def self.from_google(auth)
    find_or_create_by(email: auth.info.email, uid: auth.uid,
                      provider: auth.provider) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
    end
  end

  def password_required?
    false
  end

  def grab_avatar_url
    url = URI.parse('https://randomuser.me/api/?inc=picture')
    response = Net::HTTP.get_response(url)
    data = JSON.parse(response.body)

    data['results'][0]['picture']['large']
  end

  def grab_avatar_image
    img = URI.parse(grab_avatar_url).open
    avatar.attach(io: img, filename: "User_#{id}")
  end

  def grab_header_image
    client = Pexels::Client.new(Rails.application.credentials.dig(:pexels, :api_key))
    res = client.photos.search('ocean', page: 1, per_page: 50)
    # data = JSON.parse(res)
    num = rand(0..50)
    url = res.photos[num].src['medium']
    puts url

    img = URI.parse(url).open
    header_photo.attach(io: img, filename: "User_#{id}_header_photo")
  rescue StandardError => e
    Rails.logger.error "Error fetching image: #{e.message}"
  end
end
