require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders the show template if the token is valid" do
      bob = Fabricate(:user)
      get :show, id: bob.token
      expect(response).to render_template :show
    end

    it "redirects to the token expired page if the token is not valid" do
      get :show, id: '123abc'
      expect(response).to redirect_to invalid_token_path
    end

    it "sets the token" do
      bob = Fabricate(:user)
      get :show, id: bob.token
      expect(assigns(:token)).to eq(bob.token)
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "updates the user's password" do
        bob = Fabricate(:user, password: 'existing-password')
        post :create, token: bob.token, password: 'new-password'
        expect(bob.reload.authenticate('new-password')).to be_true
      end
      it "redirects to the sign in page" do
        bob = Fabricate(:user, password: 'existing-password')
        post :create, token: bob.token, password: 'new-password'
        expect(response).to redirect_to sign_in_path
      end
      it "notifies the user that the password has been changed" do
        bob = Fabricate(:user, password: 'existing-password')
        post :create, token: bob.token, password: 'new-password'
        expect(flash[:success]).to be_present
      end
      it "creates a new user token" do
        bob = Fabricate(:user, password: 'existing-password')
        existing_token = bob.token
        post :create, token: bob.token, password: 'new-password'
        expect(bob.reload.token).not_to eq(existing_token)
      end
    end
    context "with invalid token" do
      it "redirects to the invalid token path" do
        post :create, token: 'notatoken', password: 'butvalidpassword'
        expect(response).to redirect_to invalid_token_path
      end
    end
  end
end