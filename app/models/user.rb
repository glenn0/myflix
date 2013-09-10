class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items, order: "position ASC"
  has_secure_password

  def normalise_queue_item_positions
    queue_items.each_with_index do |qi, index|
      qi.update_attributes(position: index+1)
    end
  end
end