require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  def test_email
    @user.login = 'login'
    @user.save
    assert_equal('login@student.lu.se', @user.email)
  end

  def test_to_s
    @user.name = ''
    assert_equal(@user.to_s, @user.email)
    @user.name = 'Einstein'
    assert_equal('Einstein', @user.to_s)
  end
end
