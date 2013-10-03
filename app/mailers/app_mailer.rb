class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail to: @user.email, from: "gsource@gmail.com", subject: "You're now registered for MyFLiX!"
  end

  def password_reset_email(user)
    @user = user
    mail to: @user.email, from: "gsource@gmail.com", subject: "Seems you had some trouble logging in."
  end

  def invitation_email(invitation)
    @invitation = invitation
    mail to: @invitation.recipient_email, from: "gsource@gmail.com", subject: "#{@invitation.sender.full_name} thinks you should try MyFLiX."
  end
end