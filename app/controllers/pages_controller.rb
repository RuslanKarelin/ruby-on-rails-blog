class PagesController < ApplicationController
  def show
    @model = check_404 Page.find_by_alias(params[:page_alias])
  end
end
