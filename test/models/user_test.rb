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
    @user = User.find_or_create_by_login('ALLCAPS')
    @user.save
    assert_equal('allcaps', @user.login)
  end

  def test_should_remove_email
    @user = User.find_or_create_by_login('email@email')
    @user.save
    assert_equal('email', @user.login)
  end

  def test_email
    @user.login = 'login'
    @user.save
    assert_equal('login@student.lu.se', @user.email)
  end

  def test_verifiable
    @user.save
    key = @user.verification_key
    assert_equal(@user, User.find_by_verification_key(key))
  end

  def test_to_s
    @user.name = ''
    assert_equal(@user.to_s, @user.email)
    @user.name = 'Einstein'
    assert_equal('Einstein', @user.to_s)
  end

  def test_password
    @user.password = 'super_secret'
    @user.save
    assert(@user.authenticate('super_secret'))
  end

  def test_verify!
    assert(!@user.verified?)
    @user.verify!
    assert(@user.verified?)
  end
end
