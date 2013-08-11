class Category < ActiveRecord::Base
  has_many :videos

  def self.recent_videos(category)
    # Select top 6 videos per category
    category.videos.find(:all, order: "created_at DESC", limit: 6)
  end
end