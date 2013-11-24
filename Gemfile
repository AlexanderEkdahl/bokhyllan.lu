source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0'
gem 'sass-rails'
gem 'bourbon'
gem 'pg'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'meta-tags', require: 'meta_tags'
gem 'uglifier'
gem 'hipchat'
gem 'rack-cas'
gem 'searchkick'

group :development, :test do
  gem 'debugger'
  gem 'i18n_yaml_sorter'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'poltergeist'
end

group :staging, :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'heroku-deflater'
end
