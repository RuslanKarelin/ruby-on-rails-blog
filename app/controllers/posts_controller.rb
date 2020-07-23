class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:add_post]
  before_action :check_permissions, only: [:add_post]

  def show
    category = check_404 Category.find_by_alias(params[:category_alias])
    @model = check_404 category.posts.published.find_by_alias(params[:post_alias]) if category.present?
  end

  def add_post
    @model = Post.new(model_params)
    if @model.save
      redirect_to profile_path(current_user.profile), :notice => "Successfully created post."
    else
      redirect_to profile_path(current_user.profile), :notice => "Fail created post."
    end
  end

  private

  def model_params
    params.require(:post).permit(
        :name, :alias, :published,
        :intro_text, :text,
        :category_id, :all_tags, :user_id,
        category_ids: [],
        image_attributes: [:id, :name, :remove_name, :_destroy]
    )
  end

  def check_permissions
    redirect_to home_url(), status: 301, alert: 'Access denied!' unless current_user.is_author?
  end
end
