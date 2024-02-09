class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends_with_status(:active)

    @posts = Post.joins(:user).where(users: { id: @friends }).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    @post.save!

    redirect_to user_path(current_user), notice: 'Post published successfully!'
  end

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
