require 'spec_helper'

describe Video do

  it { should have_many(:reviews).order("created_at DESC") }
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    before(:each) do
      comedy = Category.create(name: 'Comedy')
      drama = Category.create(name: 'Drama')
      @video1 = comedy.videos.create(title: 'Family Guy', description: "Lucky there's a family guy.")
      @video2 = comedy.videos.create(title: 'Monk', description: "A quirky detective solves crime.")
      @video3 = drama.videos.create(title: 'Futurama', description: "Fry moves to the future to deliver pizza and more.")
      @video4 = comedy.videos.create(title: 'South Park', description: "Come on down to South Park and meet some friends of mine.")
      @video5 = drama.videos.create(title: 'Breaking Bad', description: "Walter White teaches chemistry and cooks meth.")
      @video6 = drama.videos.create(title: 'The Killing', description: "Murder mysteries in Seattle.")
    end

    it "returns an empty array when there is no match" do
      expect(Video.search_by_title("Not a Video")).to eq []
    end

    it "returns an array of one object when there is a exact match" do
      expect(Video.search_by_title("South Park")).to eq [@video4]
    end

    it "returns an array of one object when there is a partial match" do
      expect(Video.search_by_title("South P")).to eq [@video4]
    end

    it "returns an array of multiple items when there are multiple matches, ordered by created_at DESC" do
      expect(Video.search_by_title("ki")).to eq [@video6, @video5]
    end

    it "returns and array of 5 objects when there is no search term, ordered by created_at DESC" do
      expect(Video.search_by_title("")).to eq [@video6, @video5, @video4, @video3, @video2]
    end
  end
end