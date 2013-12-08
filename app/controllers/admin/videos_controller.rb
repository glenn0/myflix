class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:success] = "You created a new video!"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Something went wrong :("
      render :new
    end
  end
 
  private

  def require_admin
    if !current_user.admin? 
      flash[:error] = "That page is not for you."
      redirect_to home_path
    end
  end
end