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
    it "creates a queue item that is associated with the signed in user" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(bob)
    end
    it "creates a queue item that is in last position in the queue" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      famguy = Fabricate(:video)
      Fabricate(:queue_item, video: famguy, user: bob)
      southp = Fabricate(:video)
      post :create, video_id: southp.id
      southp_queue_item = QueueItem.where(video_id: southp.id, user_id: bob.id).first
      expect(southp_queue_item.position).to eq(2)
    end
    it "does not create a queue item if the video already exists in the queue" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      famguy = Fabricate(:video)
      Fabricate(:queue_item, video: famguy, user: bob)
      post :create, video_id: famguy.id
      expect(bob.queue_items.count).to eq(1)
    end
    it "redirects to sign in page for unauthenticated user" do
      session[:user_id] = nil
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    it "deletes the queue item" do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
      queue_item = Fabricate(:queue_item, user: bob)
      expect{delete :destroy, id: queue_item.id}.to change(QueueItem, :count).by(-1)
    end
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item
      expect(response).to redirect_to my_queue_path
    end
    it "does not delete queue items of other users" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      session[:user_id] = tony.id
      queue_item = Fabricate(:queue_item, user: bob)
      expect{delete :destroy, id: queue_item}.to change(QueueItem, :count).by(0)
    end
    it "redirects to the sign in page for unauthenticated users" do
      session[:user_id] = nil
      delete :destroy, id: 1
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      it "redirects to the My Queue path" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "updates the position number" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(bob.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalises the position numbers" do
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 5}, {id: queue_item2.id, position: 2}]
        expect(queue_item1.position).to eq(2)
        expect(queue_item2.position).to eq(1)
      end
    end
    context "with invalid inputs" do
    end
    context "with unauthenticated " do
      it "redirects to the sign in page for unauthenticated users" do
        session[:user_id] = nil
        post :update_queue
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with queue item that is not in the current user's queue" do
    end
  end
end