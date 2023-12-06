class LikesController < ApplicationController
  before_action :set_likable
  before_action :authenticate_user!

  def create
    @like = @likable.likes.build(user: current_user)

    @like.save

    render partial: 'shared/like_button',
           locals: { user: current_user, post: @likable }
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.likeable

    @like.destroy

    render partial: 'shared/like_button',
           locals: { user: current_user, post: @post }
  end

  def like_params
    params.require(:like).permit(:post_id)
  end

  def set_likable
    return unless like_params[:post_id].present?

    @likable = Post.find(like_params[:post_id])
  end
end
