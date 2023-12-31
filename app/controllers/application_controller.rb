class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :allowed_params, if: :devise_controller?

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def allowed_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password current_password])
  end
end
