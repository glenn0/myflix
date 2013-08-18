class ReviewsController < ApplicationController
  def create
    @review = Review.new(params[:rating, :review_text])
    if @review.save
      redirect_to video_path
    else
      render :new
    end
  end
end