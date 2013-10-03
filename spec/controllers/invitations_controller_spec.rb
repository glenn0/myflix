require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new instance of an invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_a_new Invitation
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    context "with valid inputs" do
      after { ActionMailer::Base.deliveries.clear }
      it "create an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", recipient_email: "tommy@trash.com", message: "Join up!"}
        expect(Invitation.count).to eq(1)
      end
      it "notifies the recipient by email" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", recipient_email: "tommy@trash.com", message: "Join up!"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(["tommy@trash.com"])
      end
      it "redirects to the new invitation page" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", recipient_email: "tommy@trash.com", message: "Join up!"}
        expect(response).to redirect_to new_invitation_path
      end
      it "shows a success message with recipient's name" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", recipient_email: "tommy@trash.com", message: "Join up!" }
        expect(flash[:success]).to eq "Thanks for inviting Tommy Trash to MyFLiX!"
      end
    end

    context "with invalid inputs" do
      it "doesn't create an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", message: "Join up!"}
        expect(Invitation.count).to eq(0)
      end
      it "doesn't send out an email" do
        set_current_user
        post :create, invitation: { recipient_email: "tommy@trash.com", message: "Join up!"}
        expect(ActionMailer::Base.deliveries).to be_empty 
      end
      it "shows an error message" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", message: "Join up!" }
        expect(flash[:error]).to eq "Please include a name and email, then resend."
      end
      it "redirects to the new invitation page" do
        set_current_user
        post :create, invitation: { recipient_name: "Tommy Trash", message: "Join up!"}
        expect(response).to render_template(:new)
      end
      it "sets @invitation to a new instance of an invitation" do
        set_current_user
        get :new
        expect(assigns(:invitation)).to be_a_new Invitation
      end
    end
  end
end