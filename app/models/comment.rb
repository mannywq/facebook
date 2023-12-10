# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  contents         :text
#  depth            :integer
#  likeable_type    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  likeable_id      :bigint
#  post_id          :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_likeable     (likeable_type,likeable_id)
#  index_comments_on_post_id      (post_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :commentable, polymorphic: true, optional: true
  belongs_to :likeable, polymorphic: true, optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
