require 'spec_helper'

feature "User interacts with the queue" do
  scenario "user adds videos and reorders" do
    comedy = Fabricate(:category)
    futurama = Fabricate(:video, title: "Futurama", category: comedy)
    famguy = Fabricate(:video, title: "Family Guy", category: comedy)
    southp = Fabricate(:video, title: "South Park", category: comedy)
    
    sign_in

    click_on_a_homepage_video(futurama)
    page.should have_content futurama.title

    click_link "+ My Queue"
    page.should have_content futurama.title
    page.should have_content "List Order"

    visit video_path(futurama)
    page.should_not have_content "+ My Queue"

    visit home_path
    find("a[href='/videos/#{famguy.id}']").click

    click_link "+ My Queue"
 
    visit home_path
    find("a[href='/videos/#{southp.id}']").click
    
    click_link "+ My Queue"

    fill_in "video_#{futurama.id}_position", with: 3
    fill_in "video_#{famguy.id}_position", with: 2
    fill_in "video_#{southp.id}_position", with: 1

    click_button "Update My Queue"

    expect(find("#video_#{futurama.id}_position").value).to eq("3")
    expect(find("#video_#{famguy.id}_position").value).to eq("2")
    expect(find("#video_#{southp.id}_position").value).to eq("1")
  end
end