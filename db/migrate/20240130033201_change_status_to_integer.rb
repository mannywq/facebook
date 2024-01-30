class ChangeStatusToInteger < ActiveRecord::Migration[7.1]
  def change
    remove_column :friendships, :status
    add_column :friendships, :status, :integer
  end
end
