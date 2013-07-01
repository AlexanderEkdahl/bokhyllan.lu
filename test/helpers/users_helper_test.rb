require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  def setup
    @user = build(:user)
  end

  def test_email_with_verification
    @user.login = 'email'
    assert_equal('email@student.lu.se', email_with_verification(@user))
    @user.verify!
    assert_equal('email@student.lu.se &#10003;', email_with_verification(@user))
  end
end
