require 'spec_helper'

describe Category do

  it { should have_many :videos }

  it { should validate_presence_of :name }

  describe "recent_items" do
    before(:each) do
      @comedy = Category.create(name: 'Comedy')
      @drama = Category.create(name: 'Drama')
      @romance = Category.create(name: 'Romance')
      @video1 = @drama.videos.create(title: 'Family Guy', description: "Lucky there's a family guy.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy_large.jpg')
      @video2 = @comedy.videos.create(title: 'Monk', description: "A quirky detective solves crime.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
      @video3 = @comedy.videos.create(title: 'Futurama', description: "Fry moves to the future to deliver pizza and more.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
      @video4 = @comedy.videos.create(title: 'South Park', description: "Come on down to South Park and meet some friends of mine.", small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park_large.jpg')
      @video5 = @comedy.videos.create(title: 'Breaking Bad', description: "Walter White teaches chemistry and cooks meth.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
      @video6 = @comedy.videos.create(title: 'The Killing', description: "Murder mysteries in Seattle.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
      @video7 = @comedy.videos.create(title: 'Boston Legal', description: "Law in Boston.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
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
      @video8 = @comedy.videos.create(title: 'Wilfred', description: "Ryan talks to a dog.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
      expect(@comedy.recent_videos).to eq [@video8, @video7, @video6, @video5, @video4, @video3]
    end
  end
end