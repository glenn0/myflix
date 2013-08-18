require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated user" do
      before { session[:user_id] = Fabricate(:user).id }
      let(:video) { Fabricate(:video) }

      it "assigns the requested video to @video" do
        get :show, id: video
        expect(assigns(:video)).to eq video
      end

      it "assigns all related reviews to @reviews in reverse chronilogical" do
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video
        expect(assigns(:reviews)).to eq [review2, review1]
      end

      it "creates new @review object" do
        get :show, id: video
        expect(assigns(:review)).to be_a_new Review
      end

      it "calculates average rating" do
        review1 = Fabricate(:review, rating: 2, video: video)
        review2 = Fabricate(:review, rating: 4, video: video)
        review2 = Fabricate(:review, rating: 5, video: video)
        get :show, id: video
        video.average_rating.should eq 3.7
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