source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0'
gem 'sass-rails'
gem 'bourbon'
gem 'pg'
gem 'meta-tags', require: 'meta_tags'
gem 'uglifier'
gem 'hipchat'
gem 'rack-cas'
gem 'algoliasearch-rails'
gem 'skylight'

group :development, :test do
  gem 'debugger'
  gem 'i18n_yaml_sorter'
  gem 'spring'
  gem 'quiet_assets'
end

group :test do
  gem 'capybara'
  gem 'webmock'
  gem 'simplecov', require: false
end

group :staging, :production do
  gem 'appsignal'
  gem 'puma'
  gem 'rails_12factor'
  gem 'heroku-deflater'
  gem 'rack-canonical-host'
end
