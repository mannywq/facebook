class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

    @requests = current_user.pending_friend_requests
  end

  def create
    @user = current_user
    @to_friend = friends_params[:friend]
    @friend = @user.friendships.build(friend_id: @to_friend, status: 'pending')
    @default_args = { label: 'Cancel request', method: :delete,
                      path: friends_path, css_class: 'p-2 rounded-lg bg-gray-200 text-gray-600' }

    if @friend.save

      path = { path: friend_path(@to_friend) }

      args = @default_args.merge(path)

      render partial: 'friends/user_card_button', locals: { user: friends_params[:friend] }

    else

      render 'friends/index'
    end
  end

  def destroy
    @friend = Friendship.find_by(friend_id: friends_params[:friend])

    @friend.destroy

    render partial: 'friends/user_card_button', locals: { user: friends_params[:friend] }
  end

  def friends_params
    params.require(:user).permit(:friend, :status)
  end
end
