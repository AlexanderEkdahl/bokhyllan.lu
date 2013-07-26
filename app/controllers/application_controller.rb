class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  etag { I18n.locale } # Use response.headers['Vary'] = 'Accept-Language'?
  etag { current_user.try(:id) }
  etag { [notice, alert, flash[:success]] } #refactor

  add_flash_types :success

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      http_accept_language.language_region_compatible_from(I18n::available_locales.map(&:to_s))
    end

    def logout
      reset_session
      redirect_to(root_path, notice: t(:sign_out_success))
    end

    def signed_in?
      !session[:user_id].nil?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if signed_in?
    rescue ActiveRecord::RecordNotFound
      logout
    end

    def authenticate
      redirect_to(sign_in_user_path, alert: t(:must_be_signed_in)) unless signed_in?
    end

    def must_be_verified
      render 'users/must_be_verified' unless current_user.try(:verified)
    end

    helper_method :current_user, :signed_in?
end
