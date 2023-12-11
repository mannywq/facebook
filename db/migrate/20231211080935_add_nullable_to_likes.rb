class AddNullableToLikes < ActiveRecord::Migration[7.1]
  def change
    change_column :likes, :likeable_id, :integer, null: true
    change_column :likes, :likeable_type, :string, null: true
  end
end
