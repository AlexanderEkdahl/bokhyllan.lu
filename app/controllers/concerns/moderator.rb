module Moderator
  extend ActiveSupport::Concern

  ROOM = "Mod"

  def self.initialize(api_token)
    $client = HipChat::Client.new(api_token)
  end

  def moderator(message)
    hipchat("#{current_user.email}: #{message}")
  end

  def hipchat(message)
    $client[ROOM].send('Bokhyllan.lu', message, notify: true)
  rescue HipChat::Unauthorized
  end
end
