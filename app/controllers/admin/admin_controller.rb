class Admin::AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_permissions

  WillPaginate.per_page = 10

  def check_permissions
    redirect_to home_url(), status: 301, alert: 'Access denied!' unless current_user.is_cms_user?
  end

  def delete_image?
    if model_params[:image_attributes].present? && model_params[:image_attributes][:remove_name].to_i.nonzero?
      @model.image.remove_name!
      @model.save
    end
  end
end