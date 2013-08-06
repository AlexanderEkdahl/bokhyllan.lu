class UserMailer < ActionMailer::Base
  default :from => 'ekdahlsandor@gmail.com'

  def verification_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Verify your email')
  end

  def reset_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Reset your password')
  end
end
