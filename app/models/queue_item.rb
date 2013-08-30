class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video

  def video_title
    video.title
  end

  def rating
    review = video.reviews.where(user_id: user.id).first
    review.rating if review
  end

  def category_name
    category.name
  end
end