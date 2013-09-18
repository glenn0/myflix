 require 'spec_helper'

describe ForgottenPasswordsController do
  describe "POST create" do
    context "with empty input" do
      it "redirects to the forgotten password page" do
        post :create, email: ""
        expect(response).to redirect_to forgotten_password_path
      end
      it "displays an error" do
        post :create, email: ""
        expect(flash[:error]).to eq("Please enter the email address for your account.")
      end
    end
    context "with matching user email" do
      it "redirects the user to the confirmation page" do
        Fabricate(:user, email: "bob@barker.com")
        post :create, email: "bob@barker.com"
        expect(response).to redirect_to forgotten_password_confirmation_path
      end
      it "sends an email with a password reset link" do
        Fabricate(:user, email: "bob@barker.com")
        post :create, email: "bob@barker.com" 
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bob@barker.com"])
      end
    end
    context "with non-matching email" do
      it "redirects to the forgotten password page" do
        post :create, email: "nota@user.com"
        expect(response).to redirect_to forgotten_password_path
      end
      it "displays an error" do
        post :create, email: "nota@user.com"
        expect(flash[:error]).to eq("Please enter the email address you registered with.")
      end
    end
  end  
end