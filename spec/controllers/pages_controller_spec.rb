require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  describe 'GET show' do
    it 'must be http status 200' do
      page = create(:page)
      get :show, { page_alias: page.alias }
      expect(response).to have_http_status(200)
    end

    it 'must be http status 404 if alias is empty' do
      get :show, { page_alias: '' }
      expect(response).to have_http_status(404)
    end

    it 'must be http status 404 if alias not found' do
      get :show, { page_alias: 'not_found_slug' }
      expect(response).to have_http_status(404)
    end
  end
end