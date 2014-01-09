require 'spec_helper'

feature 'User registers', {js: true, vcr: true} do
  before do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_info
    fill_in_valid_card
    click_button "Sign Up"
    expect(page).to have_content("Thanks for registering with MyFlix. Please sign in.")
  end
  scenario "with valid user info and invalid card" do
    fill_in_valid_user_info
    fill_in_invalid_card
    click_button "Sign Up"
    expect(page).to have_content("Your card number is incorrect.")
  end
  scenario "with valid user info and declined card" do
    fill_in_valid_user_info
    fill_in_declined_card
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end

  def fill_in_valid_user_info
    fill_in "Email", with: "tommy@trash.com"
    fill_in "Password", with: "123456"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_invalid_user_info
    fill_in "Email", with: "tommytrash.com"
    fill_in "Password", with: "123456"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_valid_card
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "CVC", with: "123"
    select "8 - August", from: "date_month"
    select "2015", from: "date_year"
  end

  def fill_in_invalid_card
    fill_in "Credit Card Number", with: "1234567890"
    fill_in "CVC", with: "123"
    select "8 - August", from: "date_month"
    select "2015", from: "date_year"
  end

  def fill_in_declined_card
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "CVC", with: "123"
    select "8 - August", from: "date_month"
    select "2015", from: "date_year"
  end
end