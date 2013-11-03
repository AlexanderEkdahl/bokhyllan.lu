module Analytics
  extend ActiveSupport::Concern

  def track(event, properties)
    # TODO: handle multiple events?
    @track = {event: event, properties: properties}
  end

  def alias_user(user)
    @alias = user.id
  end
end
