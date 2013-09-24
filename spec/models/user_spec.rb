require 'spec_helper'

describe User do
  it { should have_many(:reviews).order("created_at DESC") }

  it { should validate_presence_of :email }

  it { should validate_presence_of :password }

  it { should validate_presence_of :full_name }

  it { should validate_uniqueness_of :email }

  it { should validate_confirmation_of :password }

  it { should have_many(:queue_items).order("position ASC") }

  it "generates a random token when password reset is requested" do
     bob = Fabricate(:user)
     expect(bob.token).to be_present
  end

  describe "#follow" do
    it "follows another user" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      bob.follow(tony)
      expect(bob.existing_relationship?(tony)).to be_true
    end
    it "doesn't follow itself" do
      bob = Fabricate(:user)
      tony = Fabricate(:user)
      bob.follow(bob)
      expect(bob.existing_relationship?(bob)).to be_false
    end
  end
end