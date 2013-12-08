require 'spec_helper'

describe 'Admin adds new video' do
  scenario 'Admin successfully adds a new video' do
    admin = Fabricate(:admin)
    comedy = Fabricate(:category, name: "Comedy")
    sign_in(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Monk"
    select "Comedy", from: "Category"
    fill_in "Description", with: "About a detective."
    attach_file "Large cover", with: "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", with: "spec/support/uploads/monk.jpg"

  end
end