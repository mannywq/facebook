class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends.pluck(:id)

    @posts = Post.joins(:user).where(users: { id: @friends }).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    @post.save!

    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
