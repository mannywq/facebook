module UsersHelper
  def sent_request?(user)
    current_user.sent_requests.any? { |f| f.friend_id == user }
  end

  def linked?(user)
    Friendship.friends_with(current_user, user).present?
  end
end
