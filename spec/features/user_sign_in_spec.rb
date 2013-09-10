require 'spec'

feature "user signs in" do
  scenario "with valid email address and password" do
    bob = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: bob.email
    fill_in "Password", with: bob.password
    click_button
  end
end