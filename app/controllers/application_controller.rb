class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  # add etag for this
  # def render(*args)
  #   if signed_in? and !current_user.verified
  #     verify = "Please verify your account by following the link sent to #{current_user.email}"
  #     flash.now[:notice] = flash.now[:notice] ? "#{flash.now[:notice]} #{verify}" : verify
  #   end
  #   super
  # end

  add_flash_types :success

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      http_accept_language.language_region_compatible_from(I18n::available_locales.map(&:to_s))
    end

    def must_be_verified
      render 'users/must_be_verified' unless current_user.try(:verified)
    end

    def authenticate
      redirect_to(sign_in_user_path, flash: { alert: t(:must_be_signed_in) }) unless signed_in?
    end

    def signed_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user, :signed_in?
end
