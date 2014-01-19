require ::File.expand_path('../config/environment',  __FILE__)

use Rack::CanonicalHost, 'bokhyllan.lu' if Rails.env.production?
run Rails.application
