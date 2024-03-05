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
