class WelcomeMailer < ApplicationMailer
  def send_greeting_notification(user)
    @user = user
    @greeting = "Hi"
    mail to: @user.email, subject: "Thank you for signing up"
  end
end
