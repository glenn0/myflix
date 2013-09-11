class RelationshipsController < ApplicationController
  before_filter :require_user
  def index
    @relationships = current_user.leaders
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end

  def create
    leader = User.find(params[:leader_id])
    unless current_user.cant_follow?(leader) 
      Relationship.create(leader: leader, follower: current_user)
    end
    redirect_to people_path
  end
end