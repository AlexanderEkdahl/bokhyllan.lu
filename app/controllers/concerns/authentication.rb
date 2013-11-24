module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
  end

  def cas
    request.session['cas']
  end

  def signed_in?
    !cas.nil?
  end

  def current_user
    @current_user ||= User.find_or_create_by(login: cas['user']) if signed_in?
  end

  def authenticate
    head status: :unauthorized unless signed_in?
  end
end
