require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  describe "POST create" do
    context "with valid input" do
      it "creates a user" do
        expect{
          post :create, user: { email: "test@email.com", password: "password", full_name: "Some One" }
        }.to change(User, :count).by(1)
      end
      it "redirects to the sign in page" do
        post :create, user: { email: "test@email.com", password: "password", full_name: "Some One" }
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      it "does not create a user without email" do
        expect{
          post :create, user: { email: "", password: "password", full_name: "Some One" }
        }.to change(User, :count).by(0)
      end
      it "does not create a user without password" do
        expect{
          post :create, user: { email: "test@email.com", password: "", full_name: "Some One" }
        }.to change(User, :count).by(0)
      end
      it "does not create a user without name" do
        expect{
          post :create, user: { email: "", password: "password", full_name: "" }
        }.to change(User, :count).by(0)
      end
      it "renders the :new template" do
        post :create, user: { email: "", password: "password", full_name: "Some One" }
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: { email: "", password: "password", full_name: "Some One" }
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
end