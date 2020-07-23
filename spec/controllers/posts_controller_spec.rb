require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe 'GET show' do

    before(:each) do
      @category = create(:category)
      @category.posts << create(:post, category_id: @category.id, category_ids: [@category.id])
      @post = @category.posts.first
    end

    it 'must be http status 200' do
      get :show, { category_alias: @category.alias, post_alias: @post.alias }
      expect(response).to have_http_status(200)
    end

    it 'must be http status 404 if category alias is empty' do
      get :show, { category_alias: '', post_alias: @post.alias }
      expect(response).to have_http_status(404)
    end

    it 'must be http status 404 if post alias is empty' do
      get :show, { category_alias: @category.alias, post_alias: '' }
      expect(response).to have_http_status(404)
    end

    it 'must be http status 404 if category alias not found' do
      get :show, { category_alias: 'not_found', post_alias: @post.alias }
      expect(response).to have_http_status(404)
    end

    it 'must be http status 404 if post alias not found' do
      get :show, { category_alias: @category.alias, post_alias: 'not_found' }
      expect(response).to have_http_status(404)
    end
  end
end