class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(params[:invitation].merge!(sender_id: current_user.id))
    if invitation.save
      AppMailer.invitation_email(invitation).deliver
      flash[:success] = "Thanks for inviting #{invitation.recipient_name} to MyFLiX!"
      redirect_to new_invitation_path
    else
      @invitation = Invitation.new
      flash[:error] = "Please include a name and email, then resend."
      render :new
    end
  end
end