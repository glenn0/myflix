class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    if search_term.blank?
      find(:all, order: "created_at DESC", limit: 5)
    else
      find(:all, conditions: ['title LIKE ?', "%#{search_term}%"], order: "created_at DESC")
    end
  end
end