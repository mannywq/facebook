class UsersController < ApplicationController
  def index
    @users = User.page(1).per(15).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
end
