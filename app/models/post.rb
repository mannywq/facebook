# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text
#  comment_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many_attached :images do |attachable|
    attachable.variant :feed, resize_to_limit: [600, 600], saver: { quality: 80 }
    attachable.variant :large, resize_to_limit: [1500, 1500], saver: { quality: 80 }
    attachable.variant :medium, resize_to_limit: [1000, 1000], saver: { quality: 80 }
  end

  validates :body, presence: true
  # validates :content, presence: true if -> { image.blank? }
end
