require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should have_many_attached :images }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }

    it { should validate_presence_of(:body) }
  end

  describe 'Creating posts' do
    let(:post) { create(:post) }
    context 'when there is a body' do
      it 'is valid' do
        expect(post).to be_valid
      end
    end
    context 'when there is no body' do
      it 'is not valid' do
        post = Post.new(body: nil)
        expect(post).not_to be_valid
      end
    end
    context 'when an image is attached' do
      img = File.open('/Users/emanuelwetterqvist/workspace/projects/odin_project/facebook/storage/fukuoka.jpg')

      it 'has an image attached' do
        post.images.attach(io: img, filename: 'fukuoka.jpg')
        expect(post.images).to be_attached
      end

      it 'creates image variants' do
        post.images.each do |image|
          expect(image.variant(:feed)).to be_attached
          expect(image.variant(:medium)).to be_attached
          expect(image.variant(:large)).to be_attached
        end
      end
    end
  end
end
