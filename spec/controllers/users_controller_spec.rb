require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
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