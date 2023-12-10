class MakeCommentableNullable < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :commentable_id, :integer, null: true
    change_column :comments, :commentable_type, :string, null: true
  end
end
