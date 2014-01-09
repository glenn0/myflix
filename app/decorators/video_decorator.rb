class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    object.reviews.count > 0 ? object.average_rating.to_s + "/5.0" : "Not yet rated."
  end
end