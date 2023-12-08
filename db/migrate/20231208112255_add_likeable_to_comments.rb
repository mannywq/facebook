class AddLikeableToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :likeable, polymorphic: true
  end
end
