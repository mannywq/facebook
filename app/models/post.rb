class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, as: :likeable

  # validates :content, presence: true if -> { image.blank? }

end
