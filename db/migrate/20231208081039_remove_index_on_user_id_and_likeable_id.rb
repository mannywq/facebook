class RemoveIndexOnUserIdAndLikeableId < ActiveRecord::Migration[7.1]
  def change
    remove_index :likes, column: %i[user_id likeable_id]
  end
end
