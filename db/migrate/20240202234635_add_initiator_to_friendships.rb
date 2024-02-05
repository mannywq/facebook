class AddInitiatorToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :initiator, :integer
  end
end
