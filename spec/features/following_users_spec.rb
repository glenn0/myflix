require 'spec_helper'

feature 'Following users' do
  scenario "user follows then unfollows another user" do
    tony = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: tony, video: video)
    
    sign_in
    click_on_a_homepage_video(video)
    click_link tony.full_name
    click_link "Follow"
    expect(page).to have_content(tony.full_name)

    unfollow(tony)
    expect(page).not_to have_content(tony.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end