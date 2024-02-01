class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.excluding(current_user)
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
