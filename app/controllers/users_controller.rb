class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.active_friends
    @users = User.where.not(id: Friendship.where(friend: current_user).pluck(:user_id)).excluding(current_user)
  end

  def show
    @user = User.find(params[:id])

    @posts = @user.posts.order(created_at: :desc)
  end

  def upload
    @user = User.find(params[:id])
    @user.avatar.attach(params[:user][:avatar])

    redirect_to user_path(@user)
  end
end
