class RemoveResponseFromFriendships < ActiveRecord::Migration[7.1]
  def change
    remove_column :friendships, :response
  end
end
