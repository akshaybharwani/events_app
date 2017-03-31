 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def logged_in_using_omniauth?
    session[:logged_in_using_omniauth].present?
  end

  helper_method :logged_in_using_omniauth?

  protected

  # For strong parameters:
  def configure_permitted_parameters
    added_attrs = [:name, :email, :mobile_number, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
