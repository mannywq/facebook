class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

    @requests = current_user.pending_friend_requests
  end

  def create
    @user = current_user
    @friend = params['user']['friend']
    @friend = @user.friendships.build(friend_id: @friend, status: params['user']['status'])

    respond_to do |format|
      if @friend.save
        format.js
      else
        format.js
      end
    end
  end

  def friends_params
    params.require(:user).permit(:friend, :status)
  end
end
