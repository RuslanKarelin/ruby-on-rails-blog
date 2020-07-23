class TagsController < ApplicationController
  layout 'search'

  def show
    @model = nil
    @title = @h1 = 'Tag: '
    unless params[:tag].blank?
      tag = Tag.find_by_name(params[:tag])
      if tag
        @model = tag.posts if tag.posts.present?
        @title = @h1 += tag.name
      end
    end
    render 'search/show'
  end
end
