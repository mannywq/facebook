class AddDepthToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :depth, :integer
  end
end
