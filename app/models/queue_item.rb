require 'pry'

class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video

  validates_numericality_of :position, {only_integer: true}

  def video_title
    video.title
  end

  def rating
    review = video.reviews.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      new_review = Review.create(rating: new_rating, video: video, user: user)
      new_review.save(validate: false)
    end
  end

  def category_name
    category.name
  end

  private
  def review  
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end