class CommentsController < ApplicationController
  before_action :set_commentable, only: :create

  def create
    @comment = @commentable.comments.build(contents: comment_params[:contents])
    @comment.user = current_user
    @comment.commentable = @commentable

    @comment.save!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
        turbo_stream.prepend(
          @target,
          partial: 'comments/comment',
          locals: {
            comment: @comment,
            post: @post,
            commentable_id: @commentable_id,
            commentable_type: @commentable_type
          }
        )
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:contents, :post_id, :comment_id)
  end

  def set_commentable
    if comment_params[:post_id]
      puts 'Post id found'
      @target = 'comments-wrapper'
      @commentable = Post.find(comment_params[:post_id])
    elsif comment_params[:comment_id]
      puts 'Comment id found'
      @commentable = Comment.find(comment_params[:comment_id])

      @target = "#{@commentable.id}-replies"
    else
      raise "No good params #{params.inspect}"
    end
    puts "@commentable is #{@commentable.inspect}"
  end
end
