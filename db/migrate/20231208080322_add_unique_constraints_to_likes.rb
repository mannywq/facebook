class AddUniqueConstraintsToLikes < ActiveRecord::Migration[7.1]
  def change
    add_index :likes, %i[likeable_type likeable_id user_id], unique: true
  end
end
