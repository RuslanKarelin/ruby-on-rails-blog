class ProfilesController < ApplicationController
  before_action :get_model, only: [:update]
  after_action :additional_action, only: [:update]

  def initialize
    super
    @model_update_success = false
  end

  def show
    @model = check_404 Profile.find(params[:id])
    @model.build_image unless @model.image.present?
    if current_user.try(:is_author?)
      @post = Post.new
      @post.build_image
    end
  end

  def update
    if @model.update_attributes(model_params)
      @model_update_success = true
      redirect_to profile_path(@model), :notice => "Successfully updated profile."
    else
      render :show
    end
  end

  private

  def get_model
    @model = Profile.includes(user: [:roles]).find(params[:id])
  end

  def model_params
    params.require(:profile).permit(
        :name,
        :description,
        image_attributes: [:id, :name, :remove_name, :_destroy],
    )
  end

  def additional_action
    if @model_update_success
      if model_params[:image_attributes].present? && model_params[:image_attributes][:remove_name].to_i.nonzero?
        @model.image.remove_name!
        @model.save
      end
      if params[:author].present?
        @model.user.role_ids = @model.user.roles.pluck(:id) << Role.find_by_name(:author).try(:id)
        @model.save
      end
    end
  end
end
