# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :integer
#  user_id       :bigint           not null
#
# Indexes
#
#  index_likes_on_likeable                                   (likeable_type,likeable_id)
#  index_likes_on_likeable_type_and_likeable_id_and_user_id  (likeable_type,likeable_id,user_id) UNIQUE
#  index_likes_on_user_id                                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likeable).optional }
  end

  context 'when parent is a post' do
    let(:post) { create(:post) }
    let(:like) { create(:like) }

    it 'likes the post' do
      like.likeable = post
      expect(like.likeable).to eq(post)
    end
  end
  context 'when parent is a comment' do
    let(:comment) { create(:comment) }
    let(:like) { create(:like) }
    it 'likes the comment' do
      like.likeable = comment
      expect(like.likeable).to eq(comment)
    end
  end
end
