require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  def setup
    @user = build(:user)
  end

  def test_email_with_verification
    # TODO update to use localization data
    @user.login = 'email'
    assert_equal('email@student.lu.se(Not verified)', email_with_verification(@user))
    @user.verify!
    assert_equal('email@student.lu.se', email_with_verification(@user))
  end

  def test_contact_information
    @user.login = 'email'
    @user.name  = @user.phone = ''
    assert_equal({email: mail_to('email@student.lu.se')}, contact_information(@user))
    @user.phone = '+46712345'
    assert_equal({phone: '+46712345', email: mail_to('email@student.lu.se')}, contact_information(@user))
    @user.name = 'Catarina'
    assert_equal({name: 'Catarina', phone: '+46712345', email: mail_to('email@student.lu.se')}, contact_information(@user))
  end

  def test_contact_information_without_keys
    assert_nil(contact_information_without_keys(nil))
    @user.login = 'email'
    @user.name  = @user.phone = ''
    assert_equal(mail_to('email@student.lu.se'), contact_information_without_keys(@user))
    @user.phone = '+46712345'
    assert_equal("+46712345 #{mail_to('email@student.lu.se')}", contact_information_without_keys(@user))
  end
end
