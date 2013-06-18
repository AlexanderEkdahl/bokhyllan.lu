class UserMailer < ActionMailer::Base
  default :from => 'support@example.com'

  def verification_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Verify your email')
  end
end
