ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods

  def sign_in_and_verify(user)
    open_session do |session|
      session.post_via_redirect(user_path, user: { login: user.login, password: user.password })
      user.verify!
      assert_equal('/', session.path)
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  fixtures :items
end
