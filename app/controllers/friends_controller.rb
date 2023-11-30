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

    respond_to do |format|
      if @friend.save

        format.json { render template: 'users/index', status: :created }

      else

        format.html do
          render 'friends/index'
        end

        format.json do
          render json: @friend.errors, status: :unprocessable_entity
        end

      end
    end
  end

  def friends_params
    params.require(:user).permit(:friend, :status)
  end
end
