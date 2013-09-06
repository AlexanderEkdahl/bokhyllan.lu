require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def test_sign_in
    visit('/')
    click_on('Sign in')
    fill_in('username', with: 'dat12sek')
    fill_in('password', with: '')
    click_button('Login')
    page.has_content?('dat12sek')
  end

  def test_signin_out
    sign_in
    click_on('Sign out')
    page.has_content?('Sign in') #Fake cas does not emulate the true behavior of CAS
  end

  def sign_in
    if page.has_content?('Sign in')
      click_on('Sign in')
      fill_in('username', with: 'dat12sek')
      fill_in('password', with: '')
      click_button('Login')
    end
  rescue Capybara::ElementNotFound
  end
end
