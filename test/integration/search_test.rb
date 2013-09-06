require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.current_driver = :poltergeist
  end

  def test_autocomplete
    visit('/')
    fill_in 'search', with: 'Endim'
    page.has_content?('Endimensionell Analys')
  end
end
