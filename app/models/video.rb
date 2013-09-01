class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term.blank?
      find(:all, order: "created_at DESC", limit: 5)
    else
      find(:all, conditions: ['title LIKE ?', "%#{search_term}%"], order: "created_at DESC")
    end
  end

  def average_rating
    (self.reviews.map(&:rating).inject(0.0, &:+) / self.reviews.count).round(1)
  end
end