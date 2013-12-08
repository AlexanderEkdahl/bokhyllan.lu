require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def test_signin_in_a_new_user_repeatedly
    visit('/')
    assert_difference(-> { User.count }, 1) do
      sign_in('jur10cso')
    end
    assert(page.has_content?('jur10cso'))

    click_on('Logga ut')
    assert(page.has_content?('Logga in')) # Fake cas does not emulate the true behavior of CAS
                                          # where the user is shown the CAS page
    assert_difference(-> { User.count }, 0) do
      sign_in('jur10cso')
    end
  end
end
