class AddResponseToFriendship < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :response, :integer, null: true
  end
end
