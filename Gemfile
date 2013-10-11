source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0'
gem 'sass-rails'
gem 'bourbon'
gem 'pg'
gem 'jquery-rails'
gem 'twitter-typeahead-rails'
gem 'turbolinks'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'http_accept_language'
gem 'meta-tags', require: 'meta_tags'
gem 'uglifier'
gem 'hipchat'
gem 'sitemap_generator'
gem 'rack-cas'
gem 'searchkick'

group :development, :test do
  gem 'foreman', require: false
  gem 'debugger'
  gem 'quiet_assets'
  # gem 'bullet'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'poltergeist'
end

group :staging, :production do
  gem 'puma'
  gem 'rails_12factor'
end
