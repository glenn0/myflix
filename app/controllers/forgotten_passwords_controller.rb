class ForgottenPasswordsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user
      AppMailer.password_reset_email(user).deliver 
      redirect_to forgotten_password_confirmation_path
    elsif params[:email].blank?
      flash[:error] = "Please enter the email address for your account."
      redirect_to forgotten_password_path
    else
      flash[:error] = "Please enter the email address you registered with."
      redirect_to forgotten_password_path
    end
  end
end