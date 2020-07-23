require 'rails_helper'

RSpec.describe Category, :type => :model do

  describe "category model" do

    it "should be return hash" do
      @category = create(:category)
      @category.posts << create(:post, category_id: @category.id, category_ids: [@category.id])
      expect(@category.split_posts_to_group).to include(:first)
    end

    it "should be return nil" do
      @category = create(:category)
      expect(@category.split_posts_to_group).to eq nil
    end

  end
end