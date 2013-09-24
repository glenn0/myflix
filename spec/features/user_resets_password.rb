require 'spec_helper'

feature "User resets password" do
  scenario "User resets password successfully" do
    bob = Fabricate(:user, full_name: "Bob Barker", email: "bob@barker.com", password: 'old_password')
    visit sign_in_path
    
    click_link "Forgotten password?"
    fill_in "Email Address", with: "bob@barker.com"
    click_button "Send Email"

    open_email("bob@barker.com")
    current_email.click_link("Reset my password.")

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email", with: "bob@barker.com"
    fill_in "Password", with: "new_password"
    click_button "Sign in"

    expect(page).to have_content("Hi, Bob")
  end
end