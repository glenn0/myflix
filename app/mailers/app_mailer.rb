class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail to: @user.email, from: "gsource@gmail.com", subject: "You're now registered for MyFLiX!"
  end

  def password_reset_email(user)
    @user = user
    mail to: @user.email, from: "gsource@gmail.com", subject: "Seems you had some trouble logging in."
  end
end