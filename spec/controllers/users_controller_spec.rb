require 'spec_helper'
require 'pry'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end
  describe "GET new_with_invitation" do
    it "sets @user with recipient's email" do
      invite = Fabricate(:invitation)
      get :new_with_invitation, token: invite.token
      expect(assigns(:user).email).to eq(invite.recipient_email)
    end
    it "sets @user with recipient's name" do
      invite = Fabricate(:invitation)
      get :new_with_invitation, token: invite.token
      expect(assigns(:user).full_name).to eq(invite.recipient_name)
    end
    it "sets @invitation_token" do
      invite = Fabricate(:invitation)
      get :new_with_invitation, token: invite.token
      expect(assigns(:invitation_token)).to eq(invite.token)
    end
    it "renders the new user template" do
      invite = Fabricate(:invitation)
      get :new_with_invitation, token: invite.token
      expect(response).to render_template(:new)
    end
    it "redirects to the token expired page if the token is not valid" do
      get :new_with_invitation, token: '123abc'
      expect(response).to redirect_to invalid_token_path
    end
  end
  describe "POST create" do
    context "with valid input" do
      let(:post_valid_inputs) { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a user" do
        expect{post_valid_inputs}.to change(User, :count).by(1)
      end

      it "redirects to the sign in page" do
        post_valid_inputs
        expect(response).to redirect_to sign_in_path
      end

      it "creates a follow relationship from user to sender" do
        bob = Fabricate(:user)
        invite = Fabricate(:invitation, sender: bob, recipient_email: "tommy@trash.com")
        post :create, user: {email: "tommy@trash.com", password: "some_password", full_name: "Tommy Trash"}, invitation_token: invite.token
        tommy = User.where(email: "tommy@trash.com").first
        expect(tommy.existing_relationship?(bob)).to be_true
      end
      it "creates a follow relationship from the sender to the user" do
        bob = Fabricate(:user)
        invite = Fabricate(:invitation, sender: bob, recipient_email: "tommy@trash.com")
        post :create, user: {email: "tommy@trash.com", password: "some_password", full_name: "Tommy Trash"}, invitation_token: invite.token
        tommy = User.where(email: "tommy@trash.com").first
        expect(bob.existing_relationship?(tommy)).to be_true
      end
      it "expires the token"
    end

    context "with invalid input" do
      let(:post_invalid_inputs) { post :create, user: { email: "", password: "password", full_name: "Some One" } }

      it "does not create a user" do
        expect{post_invalid_inputs}.to change(User, :count).by(0)
      end

      it "renders the :new template" do
        post_invalid_inputs
        expect(response).to render_template :new
      end
      
      it "sets @user" do
        post_invalid_inputs
        expect(assigns(:user)).to be_a_new User
      end
    end

    context "sending welcome email" do
      after { ActionMailer::Base.deliveries.clear }

      it "sends welcome email to new user with valid inputs" do
        post :create, user: { email: "bob@email.com", password: "password", full_name: "Bob Barker" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bob@email.com"])
      end
      it "sends welcome email with the user's name" do
        post :create, user: { email: "bob@email.com", password: "password", full_name: "Bob Barker" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Welcome")
      end
      it "doesn't send email to user with invalid inputs" do
        post :create, user: { email: "bob@email.com", full_name: "Bob Barker" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 1 }
    end
    it "assigns @user" do
      set_current_user
      bob = Fabricate(:user)
      get :show, id: bob.id
      expect(assigns(:user)).to eq(bob)
    end
    it "assigns @queue_items" do
      set_current_user
      bob = Fabricate(:user)
      get :show, id: bob.id
      expect(assigns(:queue_items)).to eq(bob.queue_items)
    end
    it "assigns @reviews" do
      set_current_user
      bob = Fabricate(:user)
      get :show, id: bob.id
      expect(assigns(:reviews)).to eq(bob.reviews)
    end
  end
end