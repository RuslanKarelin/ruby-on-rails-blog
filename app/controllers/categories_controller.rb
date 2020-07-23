class CategoriesController < ApplicationController
  def show
    @model = check_404 Category.find_by_alias(params[:category_alias])
  end
end