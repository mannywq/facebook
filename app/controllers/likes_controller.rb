class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)
    @like.save
    @likeable = @like.likeable
    render partial: 'shared/like_button', locals: { post: @likeable }
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @likeable = @like.likeable
    @like.destroy

    render partial: 'shared/like_button', locals: { post: @likeable }
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
