class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(email: current_user.email).page(1).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
