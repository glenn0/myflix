require 'spec_helper'

describe Video do

  it "saves itself" do
    video = Video.new(title: "Family Guy", 
                      small_cover_url: "/tmp/family_guy.jpg",
                      large_cover_url: "/tmp/family_guy_large.jpg",
                      description: "Peter Griffin & Co")
    video.save
    Video.first.title.should == "Family Guy"
  end

  it { should belong_to(:category) }

  it { should validate_presence_of(:title) }
  
  it { should validate_presence_of(:description) }

end