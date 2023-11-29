class FriendsController < ApplicationController
  def index
    @friends = current_user.friends

    @requests = current_user.pending_friend_requests
  end

  def create
    @user = current_user
    @friend = current_user.friends.build(friends_params)
  end

  def friends_params
    params.permit(:user).require(:friend, :status)
  end
end
