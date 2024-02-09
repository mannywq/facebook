class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

    @requests = current_user.incoming_friend_requests.map(&:user)
  end

  def create
    @user = current_user
    @to_friend = friends_params[:friend]
    @friend = @user.friendships.build(friend_id: @to_friend,
                                      status: 'pending')

    @friend.save!

    @user = User.find(@to_friend)

    render partial: 'friends/request_friend_button',
           locals: { user: @user }
  end

  def update_friendship
    @user = User.find(params[:id])

    @friendship = @user.friendships.where(friend: current_user)

    @friendship.update!(status: friends_params[:status])

    console

    if friends_params[:status] == 'active'
      redirect_to notifications_path, notice: 'Added new friend'
    elsif friends_params[:status] == 'ignored'
      redirect_to notifications_path, notice: 'Request ignored'
    else
      render params
    end
  end

  def destroy
    @user = User.find(friends_params[:friend])
    @friend = Friendship.friends_with(current_user,
                                      friends_params[:friend]).first

    @friend&.destroy!

    render partial: 'friends/request_friend_button',
           locals: { user: @user }
  end

  def friends_params
    params.require(:user).permit(:friend, :status, :action)
  end
end
