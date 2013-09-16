class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items, order: "position ASC"
  has_many :leaders, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, class_name: "Relationship", foreign_key: :leader_id
  has_secure_password

  before_create :generate_token

  def normalise_queue_item_positions
    queue_items.each_with_index do |qi, index|
      qi.update_attributes(position: index+1)
    end
  end

  def existing_relationship?(leader)
    true if Relationship.where(follower_id: self, leader_id: leader.id).first
  end

  def cant_follow?(leader)
    self.existing_relationship?(leader) || self == leader
  end

  private
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end