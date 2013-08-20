require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      context "with valid input" do
        
        let(:post_valid_inputs) { post :create, review: Fabricate.attributes_for(:review) }

        it "creates a review" do
          expect{post_valid_inputs}.to change(Review, :count).by(1)
        end
      end
    context "with unauthenticated user"
=begin
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
=end
  end
end