class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save!
    @post = Post.find(comment_params[:post_id])
    @commentable_type = comment_params.has_key?(:commentable_type) ? comment_params[:commentable_type] : nil
    @commentable_id = comment_params.has_key?(:commentable_id) ? comment_params[:commentable_id] : nil

    respond_to(&:turbo_stream)
  end

  def comment_params
    params.require(:comment).permit(:contents, :post_id, :commentable_type, :commentable_id)
  end
end
