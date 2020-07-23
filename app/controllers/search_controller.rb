class SearchController < ApplicationController
  def show
    @model = nil
    @title = @h1 = 'Search: '
    unless params[:q].blank?
      string = params[:q]
      @model = Post.where("text LIKE '%#{string}%'")
      @title = @h1 += string
    end
  end
end
