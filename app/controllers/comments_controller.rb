class CommentsController < ApplicationController
  def add
    if (!params[:name].try(:strip).blank? && !params[:body].strip.blank?) ||
        (current_user && !params[:body].strip.blank?)
      parent_id = params[:parent_id]

      unless parent_id.blank?
        parent = Comment.find parent_id
        raise if parent.nil?
      end
      name = params[:name].try(:strip)
      body = params[:body].strip
      model = params[:type].constantize
      object = model.find(params[:model])
      user = current_user || nil
      object.comments.create name: name, body: body, parent_id: parent_id, user: user
      render partial: 'shared/comment', locals: {collection: object.comments}
    end
  end

  def destroy
    if (params[:id])
      Comment.find(params[:id]).destroy
    end
    render plain: ''
  end
end
