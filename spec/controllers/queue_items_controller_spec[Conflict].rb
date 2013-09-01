require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      queue_item_1 = Fabricate(:queue_item, user: bob)
      queue_item_2 = Fabricate(:queue_item, user: bob)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item_1, queue_item_2] )
    end
    it "redirects unauthenticated users to the sign in page" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    before { session[:user_id] = Fabricate(:user).id }

    it "redirects to the My Queue path" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a queue item" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates a queue item that is associated with the video" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates a queue item that is associated with the signed in user"
    it "creates a queue item that is in last position in the queue"
    it "does not create a queue item if the video already exists in the queue"
    it "redirects to sign in page for unauthenticated user"
  end
end