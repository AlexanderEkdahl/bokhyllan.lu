require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_verifcation
    user = create(:user)
    email = UserMailer.verification_email(user).deliver
    assert(!ActionMailer::Base.deliveries.empty?)
    assert_equal(['ekdahlsandor@gmail.com'], email.from)
    assert_equal([user.email], email.to)
    verification_key = URI.unescape((email.text_part || email.html_part || email).body
                         .decoded.match(/key=(.*)/)[1])
    assert_equal(user, User.find_by_verification_key(verification_key))
  end
end
