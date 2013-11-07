require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) {get :new} 
    end
    it "sets the @video variable" do
      set_admin_user
      get :new
      expect(assigns(:video)).to be_a_new(Video)
      expect(assigns(:video)).to be_instance_of(Video)
    end
    it_behaves_like "requires admin user" do
      let(:action) {get :new} 
    end
    it "sets a flash error for a non-admin user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) {post :create} 
    end

    it_behaves_like "requires admin user" do
      let(:action) {post :create} 
    end

    context "with valid input" do
      it "redirects to the add new video page" do
        set_admin_user
        post :create
        expect(response).to redirect_to new_admin_video_path
      end
      it "creates a video" do
        set_admin_user
        cat = Fabricate(:category)
        post :create, video: { title: "Family Guy", category_id: cat.id, description: "Something." }
        expect(cat.videos.count).to eq(1)
      end
      it "sets the flash success message" do
        set_admin_user
        cat = Fabricate(:category)
        post :create, video: { title: "Family Guy", category_id: cat.id, description: "Something." }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a video" do
        set_admin_user
        cat = Fabricate(:category)
        post :create, video: { category_id: cat.id, description: "Something." }
        expect(cat.videos.count).to eq(0)
      end
      it "redirects to the add new video page"
      it "sets the @video variable"
      it "sets the flash success message"
    end
  end
end