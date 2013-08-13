class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  add_flash_types :success

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      http_accept_language.language_region_compatible_from(I18n::available_locales.map(&:to_s))
    end

    def signed_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
    end

    def authenticate
      redirect_to(sign_in_user_path, alert: t(:must_be_signed_in)) unless signed_in?
    end

    def must_be_verified
      render 'users/must_be_verified' unless current_user.try(:verified)
    end

    helper_method :current_user, :signed_in?
end
