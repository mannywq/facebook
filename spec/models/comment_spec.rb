require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post).optional }
    it { should belong_to(:commentable) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
  describe 'Creating a comment' do
    context 'when parent is a post' do
      let(:post) { create(:post) }
      let(:comment) { create(:comment, :with_post, commentable: post) }

      it 'creates a comment associated with the post' do
        expect(comment.commentable).to eq(post)
      end
    end
    context 'when parent is a comment' do
      let(:parent_comment) { create(:comment) }
      let(:comment) { create(:comment, :with_comment, commentable: parent_comment) }

      it 'creates a comment associated with the comment' do
        expect(comment.commentable).to eq(parent_comment)
      end
    end
  end
end
