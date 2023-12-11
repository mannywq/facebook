class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable, only: :create

  def create
    @like = current_user.likes.new(like_params)
    @like.save!
    render partial: 'shared/like_button', locals: { post: @likeable }
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy!

    render partial: 'shared/like_button', locals: { post: @like.likeable }
  end

  private

  def set_likeable
    @likeable = like_params[:likeable_type] == 'Post' ? @likeable = Post.find(like_params[:likeable_id]) : @likeable = Comment.find(like_params[:likeable_id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
