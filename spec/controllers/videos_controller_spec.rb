require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated user" do
      before { session[:user_id] = Fabricate(:user).id }

      it "assigns the requested video to @video" do
        video = Fabricate(:video)
        get :show, id: video
        expect(assigns(:video)).to eq video
      end
    end
    context "with unauthenticated user" do
      it "redirects user to sign in page" do
        video = Fabricate(:video)
        get :show, id: video
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST search" do
    context "with authenticated user" do
      it "assigns results to @results" do
        session[:user_id] = Fabricate(:user).id
        video = Video.create(title: "Family Guy", description: "A description.")
        post :search, search_term: "Family"
        expect(assigns(:results)).to eq [video]
      end
    end
    context "with unauthenticated user" do
      it "redirect user to sign in page" do
        video = Video.create(title: "Family Guy", description: "A description.")
        post :search, search_term: "Family"
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end