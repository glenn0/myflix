require 'spec_helper'

feature "User invites friend" do
  scenario "User invites friend who then signs up" do
    bob = Fabricate(:user)
    sign_in(bob)

    visit new_invitation_path
    fill_in "Their name", with: "Tommy Trash"
    fill_in "Their email", with: "tommy@trash.com"
    fill_in "Why should they try MyFLiX?", with: "Because it's good!"
    click_button "Send Invitation"
    visit sign_out_path

    open_email "tommy@trash.com"
    current_email.click_link "Accept the invitation."

    fill_in "Password", with: "password"
    click_button "Sign Up"

    fill_in "Email", with: "tommy@trash.com"
    fill_in "Password", with: "password"
    click_button "Sign in"

    click_link "People"
    expect(page).to have_content bob.full_name
    visit sign_out_path

    sign_in(bob)
    click_link "People"
    expect(page).to have_content "Tommy Trash"

    clear_email 
  end
end