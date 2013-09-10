require 'spec_helper'

feature "user signs in" do
  scenario "with valid email address and password" do
    bob = Fabricate(:user)
    sign_in(bob)
    page.should have_content bob.full_name.split.first
  end
end