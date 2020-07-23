class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include App

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

  before_action :init, only: [:show, :new]
end
