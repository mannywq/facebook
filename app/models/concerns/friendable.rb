module Friendable
  extend ActiveSupport::Concern

  def incoming_friend_requests
    Friendship.pending_requests(id) # Our user is the friend in this scope
  end

  def sent_requests
    Friendship.sent_requests(id)
  end

  def friends
    Friendship.friends(id)
  end

  def request_friend(friend_id)
    friendship = Friendship.friends_with(id, friend_id)

    return false unless friendship.empty?

    Friendship.create!(user_id: id, friend_id:, status: :pending)
    true
  end

  def friends_with_status(status)
    friendships.friends_with_status(id, status)
  end

  def friends?(friend)
    Friendship.where(user_id: id, friend_id: friend.id).or(Friendship.where(user_id: friend.id, friend_id: id)).any?
  end
end
