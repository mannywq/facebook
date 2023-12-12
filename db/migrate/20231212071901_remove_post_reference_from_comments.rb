class RemovePostReferenceFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_reference :comments, :post
  end
end
