module UserAgent
  extend ActiveSupport::Concern

  included do
    helper_method :user_agent
  end

  def user_agent
    case request.user_agent
    when /Macintosh/
      :apple
    end
  end
end
