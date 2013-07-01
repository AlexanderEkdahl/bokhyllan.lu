require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  def test_should_not_allow_duplicates
    dup = @user.dup
    assert(@user.save)
    assert(!dup.save)
  end

  def test_should_normalize_login
    @user.login = 'ALLCAPS'
    @user.save
    assert_equal(@user.login, 'allcaps')
  end

  def test_should_remove_email
    @user.login = 'email@email'
    @user.save
    assert_equal(@user.login, 'email')
  end

  def test_email
    @user.login = 'login'
    @user.save
    assert_equal(@user.email, 'login@student.lu.se')
  end

  def test_verifiable
    @user.save
    key = @user.verification_key
    assert_equal(User.find_by_verification_key(key), @user)
  end

  def test_to_s
    @user.name = ''
    assert_equal(@user.to_s, @user.email)
    @user.name = 'Einstein'
    assert_equal(@user.to_s, 'Einstein')
  end

  def test_password
    @user.password = 'super_secret'
    @user.save
    assert(@user.authenticate('super_secret'))
  end
end
