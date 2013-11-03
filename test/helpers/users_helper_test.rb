require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  def setup
    @user = build(:user)
  end

  def test_contact_information
    @user.login = 'email'
    @user.name  = @user.phone = ''
    assert_equal({email: mail_to('email@student.lu.se')}, contact_information(@user))
    @user.phone = '+46712345'
    assert_equal({phone: tel_to('+46712345'), email: mail_to('email@student.lu.se')}, contact_information(@user))
    @user.name = 'Catarina'
    assert_equal({name: 'Catarina', phone: tel_to('+46712345'), email: mail_to('email@student.lu.se')}, contact_information(@user))
  end

  def test_incomplete_profile?
    assert incomplete_profile?(@user)
    @user.name = 'Joacim'
    assert incomplete_profile?(@user)
    @user.name = ''
    @user.phone = '123456789'
    assert incomplete_profile?(@user)
    @user.name = 'Joacim'
    assert !incomplete_profile?(@user)
  end
end
