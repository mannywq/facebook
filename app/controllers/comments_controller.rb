class CommentsController < ApplicationController
  before_action :set_commentable, only: :create

  def create
    @comment = @commentable.comments.build(contents: comment_params[:contents])
    @comment.user = current_user
    @comment.commentable = @commentable

    @comment.save!

    respond_to(&:turbo_stream)
  end

  private

  def comment_params
    params.require(:comment).permit(:contents, :post_id, :comment_id)
  end

  def set_commentable
    if comment_params[:post_id]
      puts 'Post id found'
      @commentable = Post.find(comment_params[:post_id])
    elsif comment_params[:comment_id]
      puts 'Comment id found'
      @commentable = Comment.find(comment_params[:comment_id])
    else
      raise "No good params #{params.inspect}"
    end
    puts "@commentable is #{@commentable.inspect}"
  end
end
