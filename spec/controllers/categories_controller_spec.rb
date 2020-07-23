require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe 'GET show' do
    it 'must be http status 200' do
      category = create(:category)
      get :show, { category_alias: category.alias }
      expect(response).to have_http_status(200)
    end

    it 'must be http status 404 if alias is empty' do
      get :show, { category_alias: '' }
      expect(response).to have_http_status(404)
    end

    it 'must be http status 404 if alias not found' do
      get :show, { category_alias: 'not_found_slug' }
      expect(response).to have_http_status(404)
    end
  end
end