require 'spec_helper'

describe User do
  it { should have_many(:reviews).order("created_at DESC") }

  it { should validate_presence_of :email }

  it { should validate_presence_of :password }

  it { should validate_presence_of :full_name }

  it { should validate_uniqueness_of :email }

  it { should validate_confirmation_of :password }

  it { should have_many(:queue_items).order("position ASC") }
end