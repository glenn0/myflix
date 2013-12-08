require 'spec_helper'

describe Category do

  it { should have_many :videos }

  it { should validate_presence_of :name }

  describe "recent_items" do
    before(:each) do
      @comedy = Category.create(name: 'Comedy')
      @drama = Category.create(name: 'Drama')
      @romance = Category.create(name: 'Romance')
      @video1 = @drama.videos.create(title: 'Family Guy', description: "Lucky there's a family guy.")
      @video2 = @comedy.videos.create(title: 'Monk', description: "A quirky detective solves crime.")
      @video3 = @comedy.videos.create(title: 'Futurama', description: "Fry moves to the future to deliver pizza and more.")
      @video4 = @comedy.videos.create(title: 'South Park', description: "Come on down to South Park and meet some friends of mine.")
      @video5 = @comedy.videos.create(title: 'Breaking Bad', description: "Walter White teaches chemistry and cooks meth.")
      @video6 = @comedy.videos.create(title: 'The Killing', description: "Murder mysteries in Seattle.")
      @video7 = @comedy.videos.create(title: 'Boston Legal', description: "Law in Boston.")
    end

    it "returns an empty array when there are no videos in the category" do
      expect(@romance.recent_videos).to eq []
    end

    it "returns an array of <6 videos when there are less than 6 videos in the category, ordered by created_at DESC" do
      expect(@drama.recent_videos).to eq [@video1]
    end

    it "returns an array of 6 videos when there are 6 videos in the category, ordered by created_at DESC" do
      expect(@comedy.recent_videos).to eq [@video7, @video6, @video5, @video4, @video3, @video2]
    end
    it "returns an array of 6 videos when there are more than 6 videos in the category, ordered by created_at DESC" do
      @video8 = @comedy.videos.create(title: 'Wilfred', description: "Ryan talks to a dog.")
      expect(@comedy.recent_videos).to eq [@video8, @video7, @video6, @video5, @video4, @video3]
    end
  end
end