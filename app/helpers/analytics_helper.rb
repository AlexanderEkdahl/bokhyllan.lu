module AnalyticsHelper
  def traits(user = current_user)
    hash = {}

    hash[:created]  = user.created_at
    hash[:username] = user.login
    hash[:email]    = user.email
    hash[:name]     = user[:name] unless user[:name].blank?
    hash[:phone]    = user.phone unless user.phone.blank?

    hash.to_json
  end

  def alias_user
    @alias.nil? ? "" : "analytics.alias('#{@alias}');"
  end

  def identify
    signed_in? ? "analytics.identify('#{current_user.id}', #{traits});" : ""
  end

  def track
    @track.nil? ? "" : "analytics.track('#{@track[:event]}', #{@track[:properties].to_json});"
  end

  def load
    ENV['SEGMENTIO'].nil? ? "" : "analytics.load('#{ENV['SEGMENTIO']}');"
  end

  def analytics
    javascript_tag(load, data: { 'data-turbolinks-eval' => false }) +
    javascript_tag(alias_user + identify + track)
  end
end
