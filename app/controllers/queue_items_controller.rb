class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: current_user, position: new_queue_item_position) unless current_user_queued_video?(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if queue_item.user == current_user
    redirect_to my_queue_path
  end

  def update_queue
    params[:queue_items].each do |qi|
      queue_item = QueueItem.find(qi["id"])
      queue_item.update_attributes(position: qi["position"])
    end

    current_user.queue_items.each_with_index do |qi, index|
      qi.update_attributes(position: index+1)
    end
    redirect_to my_queue_path
  end
end

private

def new_queue_item_position
  current_user.queue_items.count + 1
end

def current_user_queued_video?(video)
  current_user.queue_items.map(&:video).include?(video)
end