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
  end
end