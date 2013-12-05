require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:dat12sek)
  end

  def test_email
    @user.login = 'login'
    @user.save
    assert_equal('login@student.lu.se', @user.email)
    @user.email = 'email@hotmejl.se'
    assert_equal('email@hotmejl.se', @user.email)
    @user.email = ''
    assert_equal('login@student.lu.se', @user.email)
  end

  def test_to_s
    @user.name = ''
    assert_equal(@user.name, @user.email)
    @user.name = 'Einstein'
    assert_equal('Einstein', @user.name)
  end
end
