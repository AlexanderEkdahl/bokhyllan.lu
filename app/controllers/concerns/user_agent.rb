module UserAgent
  extend ActiveSupport::Concern

  included do
    helper_method :user_agent
  end

  def apple?
    request.user_agent =~ /apple/i
  end

  def user_agent
    :apple if apple?
  end
end
