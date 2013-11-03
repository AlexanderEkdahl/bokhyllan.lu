module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authorize

    helper_method :current_user, :signed_in?
  end

  def cas
    request.session['cas']
  end

  def signed_in?
    !cas.nil?
  end

  def authorize
    if signed_in?
      @current_user = User.find_or_create_by(login: cas['user']) do
        @should_alias = true
      end
      alias_user(@current_user) if @should_alias
    end
  end

  def current_user
    @current_user
  end

  def authenticate
    head status: :unauthorized unless signed_in?
  end
end
