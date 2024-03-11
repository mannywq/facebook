class AddCommentCountToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :comment_count, :integer, default: 0
  end
end
