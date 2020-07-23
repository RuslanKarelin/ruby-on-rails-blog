require 'rails_helper'

RSpec.describe Post, :type => :model do

  describe "post model" do

    before(:each) do
      @category = create(:category)
      @category.posts << create(:post, category_id: @category.id, category_ids: [@category.id])
      @post = @category.posts.first
    end

    describe "post comments" do
      it "should be two comments for post" do
        @post.comments << create(:comment)
        @post.comments << create(:comment)
        expect(@post.comments.count).to eq 2
      end
    end

    describe "post tags" do
      it "should be two tags for post" do
        @post.all_tags = 'tag1, tag2'
        expect(@post.tags.count).to eq 2
      end

      it "should be all tags field name as a string" do
        @post.tags << create(:tag, name: 'tag1')
        @post.tags << create(:tag, name: 'tag2')
        expect(@post.all_tags).to eq 'tag1, tag2'
      end
    end
  end
end