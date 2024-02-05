class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

    @requests = current_user.pending_friend_requests.map(&:user)
  end

  def create
    @user = current_user
    @to_friend = friends_params[:friend]
    @friend = @user.friendships.build(friend_id: @to_friend, status: 'pending')

    @friend.save!

    render partial: 'friends/request_friend_button',
           locals: { user: friends_params[:friend] }
  end

  def update_friendship
    @user = User.find(params[:id])

    @friendship = @user.friendships.where(friend: current_user)

    @friendship.update!(status: friends_params[:status])

    console

    if friends_params[:status] == :active
      redirect_to notifications_path, notice: 'Added new friend'
    else
      redirect_to notifications_path, notice: 'Request ignored'
    end
  end

  def destroy
    @friend = Friendship.find_by(friend_id: friends_params[:friend])

    @friend.destroy

    render partial: 'friends/request_friend_button',
           locals: { user: friends_params[:friend] }
  end

  def friends_params
    params.require(:user).permit(:friend, :status)
  end
end
