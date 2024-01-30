class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(email: current_user.email).page(1).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])

    @posts = @user.posts
  end

  def upload
    @user = User.find(params[:id])
    @user.avatar.attach(params[:user][:avatar])

    redirect_to user_path(@user)
  end
end
