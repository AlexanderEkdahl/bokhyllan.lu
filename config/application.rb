require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(:default, Rails.env)

module Bokhyllan
  class Application < Rails::Application
    config.time_zone = 'Stockholm'

    config.i18n.fallbacks = true

    config.action_view.field_error_proc = Proc.new { |html_tag, _| html_tag }
  end
end
