class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_invitation
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email, full_name: invitation.recipient_name)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to invalid_token_path
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "MyFlix subscription for #{@user.email}."
      )
      if charge.successful?
        @user.save
        handle_invitation
        AppMailer.delay.welcome_email(@user)
        redirect_to sign_in_path
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end
end

private

def handle_invitation
  if params[:invitation_token].present?
    invitation = Invitation.where(token: params[:invitation_token]).first
    @user.follow(invitation.sender)
    invitation.sender.follow(@user)
    invitation.update_column(:token, nil)
  end
end