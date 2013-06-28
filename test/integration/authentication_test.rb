require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def test_sign_up
    get(sign_in_user_path)
    assert_response(:success)

    user_attributes = attributes_for(:user)
    assert_difference(-> { ActionMailer::Base.deliveries.size }, +1) do
      assert_difference(-> { User.all.count }, +1) do
        post_via_redirect('/user', user: { login: user_attributes[:login], password: user_attributes[:password] })
        assert_equal('/', path)
      end
    end

    user = User.last
    assert(!user.verified?, 'User email should not be verified by default')
    email = ActionMailer::Base.deliveries.last
    verification_link = (email.text_part || email.html_part || email).body
                          .decoded.match(/#{verify_user_path}\?key=.*/)[0]
    get_via_redirect(verification_link)
    assert_equal('/', path)
    user.reload
    assert(user.verified?, 'User email should be verified')

    get_via_redirect(sign_out_user_path)
    assert_equal('/', path)

    assert_difference(-> { ActionMailer::Base.deliveries.size }, 0) do
      assert_difference(-> { User.all.count }, 0) do
        post_via_redirect('/user', user: { login: user_attributes[:login], password: user_attributes[:password] })
        assert_equal('/', path)
      end
    end
  end
end
