class Admin::UsersController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Users'
    @model = User.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create user'
    @model = User.new
    @model.build_profile.build_image
  end

  def create
    @model = User.new(model_params)
    if @model.save
      redirect_to admin_users_path, :notice => "Successfully created user."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit user'
    @model.profile.build_image unless @model.profile.image.present?
  end

  def update
    if @model.update_attributes(model_params)
      delete_image?
      redirect_to admin_users_path, :notice => "Successfully updated user."
    else
      render :edit
    end
  end

  def destroy
    @model = User.find(params[:id])
    @model.destroy
    redirect_to admin_users_path, :notice => "Successfully destroyed user."
  end

  def delete_image?
    if model_params[:profile_attributes][:image_attributes].present? && model_params[:profile_attributes][:image_attributes][:remove_name].to_i.nonzero?
      @model.profile.image.remove_name!
      @model.save
    end
  end

  private

  def get_model
    @model = User.find(params[:id])
  end

  def model_params
    user_params = params.require(:user).permit(
        :email,
        :password, :password_confirmation,
        role_ids: [],
        profile_attributes: [:id, :name, :description, :social, :ban, image_attributes: [:id, :name, :remove_name]]
    )

    user_params.delete(:password) unless user_params[:password].present?
    user_params.delete(:password_confirmation) unless user_params[:password_confirmation].present?

    user_params
  end
end