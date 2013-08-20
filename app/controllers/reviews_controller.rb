class ReviewsController < ApplicationController
  def create
    @video = Vi
    @review = Review.new(params[:review])
    if @review.save
      redirect_to video_path
    else
      render :new
    end
  end
end