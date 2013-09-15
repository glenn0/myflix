class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "welcome@myflix.com", subject: "You're now registered for MyFLiX!"
  end
end