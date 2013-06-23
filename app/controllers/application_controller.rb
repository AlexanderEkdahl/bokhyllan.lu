class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  # def render(*args)
  #   if signed_in? and !current_user.verified
  #     verify = "Please verify your account by following the link sent to #{current_user.email}"
  #     flash.now[:notice] = flash.now[:notice] ? "#{flash.now[:notice]} #{verify}" : verify
  #   end
  #   super
  # end

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      http_accept_language.language_region_compatible_from(I18n::available_locales.map(&:to_s))
    end

    def authenticate
      head :forbidden unless signed_in?
    end

    def signed_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user, :signed_in?
end
