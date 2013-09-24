class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: "User"

  validates_presence_of :recipient_name, :recipient_email

  before_create :generate_token

  private
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end