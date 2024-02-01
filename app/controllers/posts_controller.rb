class PostsController < ApplicationController
  def index
    @friends = current_user.friends.pluck(:id)

    @posts = Post.joins(:user).where(users: { id: @friends }).order(created_at: :desc)
  end
end
