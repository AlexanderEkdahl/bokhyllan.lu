class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  add_flash_types :success

  private

    def signed_in?
      !request.session['cas'].nil?
    end

    def current_user
      @current_user ||= User.find_or_create_by(login: request.session['cas']['user']) if signed_in?
    end

    def authenticate
      head status: :unauthorized unless signed_in?
    end

    helper_method :current_user, :signed_in?
end
