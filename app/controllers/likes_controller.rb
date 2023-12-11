class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: :create

  def create
    @like = @likeable.likes.build(user: current_user)
    @like.save!
    render partial: 'shared/like_button', locals: { post: @likeable }
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy!

    render partial: 'shared/like_button', locals: { post: @likeable }
  end

  private

  def set_likeable
    @likeable = like_params[:post_id] ? Post.find(like_params[:post_id]) : Comment.find(like_params[:comment_id])
  end

  def like_params
    params.require(:like).permit(:user_id, :comment_id, :post_id)
  end
end
