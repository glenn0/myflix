require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the :new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to home path for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end
  describe "POST create" do
    context "valid credentials" do
      it "sets user session" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(session[:user_id]).to eq user.id
      end
      it "redirects to home path" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(response).to redirect_to home_path
      end
      it "sets notice" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(flash[:notice]).to eq "Welcome back."
      end
    end
    context "invalid credentials" do
      it "does not set user session" do
        user = User.new(email: "test@email.com", password: "correct", full_name: "Bob")
        post :create, email: "test@email.com", password: "wrong"
        expect(session[:user_id]).to be_blank
      end
      it "shows error" do
        user = User.new(email: "test@email.com", password: "correct", full_name: "Bob")
        post :create, email: "test@email.com", password: "wrong"
        expect(flash[:error]).to eq "Double check your email and password, then try again or register."
      end
      it "redirects to sign in path" do
        user = User.new(email: "test@email.com", password: "correct", full_name: "Bob")
        post :create, email: "test@email.com", password: "wrong"
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe "GET destroy" do
    it "removes the user session" do
      get :destroy
      expect(session[:user_id]).to be_blank
    end
    it "redirects to root path" do
      get :destroy
      expect(response).to redirect_to root_path
    end
    it "sets notice" do
      get :destroy
      expect(flash[:notice]).to eq "Ciao for now."
    end
  end
end