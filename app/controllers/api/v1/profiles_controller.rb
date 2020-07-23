class Api::V1::ProfilesController < Api::V1::ApiController
  before_action :doorkeeper_authorize!
  respond_to    :json

  def me
    render json: current_resource_owner
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
