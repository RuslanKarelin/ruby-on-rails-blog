require 'rails_helper'

RSpec.describe Admin::CategoriesController, :type => :controller do
  include Devise::TestHelpers

  before (:each) do
    sign_in User.find(1)
  end

  describe 'check action create' do

    it 'should be redirect to admin_categories_path' do
      post :create, category: {name: 'new category'}
      expect(response).to redirect_to(admin_categories_path)
      end

    it 'should be render template admin/categories/new' do
      post :create, category: {name: ''}
      expect(response).to render_template('admin/categories/new')
    end

  end

  describe 'check action update' do

    it 'should be redirect to admin_categories_path' do
      @category = create(:category)
      put :update, :id => @category.id, category: @category.attributes = { :name => "new title" }
      expect(response).to redirect_to(admin_categories_path)
    end

  end
end