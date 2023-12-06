class LikesController < ApplicationController
  before_action :set_likable
  before_action :authenticate_user!

  def create
    @like = @likable.likes.build(user: current_user)
  end

  def destroy; end

  def like_params
    params.require(:like).permit(:post_id)
  end

  def set_likable
    return unless params[:post_id].present?

    @likable = Post.find(params[:post_id])

    return if @likable

    render 'Error'
  end
end
