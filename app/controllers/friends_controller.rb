class FriendsController < ApplicationController
  def index
    @friends = current_user.friends

    @requests = current_user.pending_friend_requests
  end
end
