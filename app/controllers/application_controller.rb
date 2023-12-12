class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  def user_params
    params.require(:user).permit(:phone_number, :name, :image)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number, :image])
  end
end
