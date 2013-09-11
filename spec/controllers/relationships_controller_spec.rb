require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
    it "assigns @relationships to the current users following relationships" do
      bob = Fabricate(:user)
      set_current_user(bob)
      tony = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: tony)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: tony)
      let(:action) { delete :destroy, id: relationship.id }
    end
    it "redirects to the people page" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      set_current_user(bob)
      relationship = Fabricate(:relationship, follower: bob, leader: tony)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end
    it "removes relationship if the current user is the follower" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      set_current_user(bob)
      relationship = Fabricate(:relationship, follower: bob, leader: tony)
      expect{delete :destroy, id: relationship.id}.to change(Relationship, :count).by(-1)
    end
    it "doesn't remove the relation is the current user is the follower" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      set_current_user(bob)
      relationship = Fabricate(:relationship, follower: tony, leader: bob)
      expect{delete :destroy, id: relationship.id}.to change(Relationship, :count).by(0)
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      let(:action) { post :create, leader_id: tony.id }
    end
    it "redirects to the people path" do
      bob = Fabricate(:user)
      set_current_user(bob)
      tony = Fabricate(:user)
      post :create, leader_id: tony.id
      expect(response).to redirect_to people_path
    end
    it "creates a relationship between the current user and selected leader" do
      bob = Fabricate(:user)
      set_current_user(bob)
      tony = Fabricate(:user)
      expect{post :create, leader_id: tony.id}.to change(Relationship, :count).by(1)
    end
    it "prevents a user from following a leader more than once concurrently" do
      bob = Fabricate(:user)
      set_current_user(bob)
      tony = Fabricate(:user)
      existing_relationship = Fabricate(:relationship, follower: bob, leader: tony)
      expect{post :create, leader_id: tony.id}.to change(Relationship, :count).by(0)
    end
    it "prevents a user from following themselves" do
      bob = Fabricate(:user)
      set_current_user(bob)
      expect{post :create, leader_id: bob.id}.to change(Relationship, :count).by(0)
    end
  end
end