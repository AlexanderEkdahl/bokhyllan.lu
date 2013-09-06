require 'test_helper'

class MainTest < ActionDispatch::IntegrationTest
  def test_logo
    visit('/')
    page.has_content?('Bokhyllan.lu')
    page.has_selector?('img')
    # click_on('Bokhyllan.lu')
    # assert_equal('/', current_path)
  end
end
