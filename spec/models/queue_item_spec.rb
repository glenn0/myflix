require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer}

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "#rating" do
    it "returns the most recent review rating from the associated user when review is present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      video_review1 = Fabricate(:review, video: video, user: user)
      video_review2 = Fabricate(:review, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(video_review2.rating)
    end
    it "returns nil when the review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "rating=" do
    context "user review already exists" do
      it "changes the rating of the review" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, user: user, video: video, rating: 1)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        queue_item.rating = 2
        expect(Review.first.rating).to eq(2)
      end
      it "removes the rating of the review" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        review = Fabricate(:review, user: user, video: video, rating: 1)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        queue_item.rating = nil
        expect(Review.first.rating).to be_nil
      end
    end
    context "no users review already exists" do
      it "create the review with a rating" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        queue_item.rating = 2
        expect(Review.first.rating).to eq(2)
      end
=begin
      it "does not create the review with a rating if rating is invalid" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        queue_item.rating = 2.2
        expect(Review.count).to eq(0)
      end
=end
    end
  end

  describe "#category_name" do
    it "returns the category name for the video" do
      category = Fabricate(:category, name: "Fun")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("Fun")
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category, name: "Fun")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end