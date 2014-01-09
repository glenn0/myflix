require 'spec_helper'

feature "User invites friend", {js: true} do
    before do
        StripeWrapper::Charge.stub(:create)
    end
  scenario "User invites friend who then signs up" do    
    bob = Fabricate(:user)
    sign_in(bob)

    # User 1 requests invite
    visit new_invitation_path
    fill_in "Their name", with: "Tommy Trash"
    fill_in "Their email", with: "tommy@trash.com"
    fill_in "Why should they try MyFLiX?", with: "Because it's good!"
    click_button "Send Invitation"
    visit sign_out_path

    # User 2 gets invite
    open_email "tommy@trash.com"
    current_email.click_link "Accept the invitation."

    # Signs up
    fill_in "Password", with: "password"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "CVC", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"

    click_button "Sign Up"

    # Gets welcome email
    fill_in "Email", with: "tommy@trash.com"
    fill_in "Password", with: "password"
    click_button "Sign in"

    # Sees that they follow User 1
    click_link "People"
    expect(page).to have_content bob.full_name
    visit sign_out_path

    # User 1 sees that they follow User 2
    sign_in(bob)
    click_link "People"
    expect(page).to have_content "Tommy Trash"

    clear_email 
  end
end