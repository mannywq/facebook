# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  initiator  :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_friendships_on_friend_id              (friend_id)
#  index_friendships_on_user_id                (user_id)
#  index_friendships_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  enum status: { sent: 0, incoming: 1, active: 2, ignored: 3 }

  validate :no_self_referential_friendship

  scope :outgoing_requests, lambda { |id|
                              where(friend_id: id, status: :sent)
                            }
  scope :incoming_requests, ->(id) { where(friend_id: id, status: :incoming) }
  def self.friends_with(user_id, friend_id)
    where(user_id:,
          friend_id:).or(where(user_id: friend_id,
                               friend_id: user_id))
  end

  private

  def no_self_referential_friendship
    return unless user_id == friend_id

    errors.add(:base,
               'Users cannot be friends with themselves')
  end
end
