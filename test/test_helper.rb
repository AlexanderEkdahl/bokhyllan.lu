ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods

  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def set_current_user(user)
    # Does not work
    @response.session['cas'] = { 'user' => user.login }
  end

  fixtures :all
end
