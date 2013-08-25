source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0'
gem 'sass-rails'
gem 'bourbon'
gem 'pg'
gem 'jquery-rails'
gem 'twitter-typeahead-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'http_accept_language', github: 'DouweM/http_accept_language', branch: 'no-middleware-no-crash'
gem 'meta-tags', require: 'meta_tags'
gem 'uglifier'
gem 'hipchat'
gem 'tire'
gem 'sitemap_generator'

group :development, :test do
  gem 'foreman'
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :staging, :production do
  gem 'newrelic_rpm'
  gem 'puma'
  gem 'rails_12factor'
end
