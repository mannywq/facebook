class AddIndexToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
