require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'webmock/test_unit'
require 'algolia/webmock'

WebMock.stub_request(:post, /.*\.hipchat.com\/.*/)
WebMock.enable!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  fixtures :all

  def visit_and_sign_in(link, login = users(:dat12sek).login)
    visit(link)
    fill_in('username', with: login)
    fill_in('password', with: '')
    click_button('Login')
  end

  def sign_in(login = users(:dat12sek).login)
    click_on('Logga in')
    fill_in('username', with: login)
    fill_in('password', with: '')
    click_button('Login')
  end

  def teardown
    click_on('Logga ut') if page.has_content?('Logga ut')
  end
end
