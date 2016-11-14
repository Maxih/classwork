require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "brian"
      fill_in 'Password', with: "password"
      click_on "Sign Up"

    end


    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "brian"
    end

  end

  feature "logging in" do
    before(:each) do
      User.create(username: "brian", password: "password")
      visit new_session_url
      fill_in 'Username', with: "brian"
      fill_in 'Password', with: "password"
      click_on "Log In"
    end

    scenario "shows username on the homepage after login" do
      expect(page).to have_content "brian"
    end

  end

  feature "logging out" do
    before(:each) do
      User.create(username: "brian", password: "password")
      visit new_session_url
    end

    scenario "begins with a logged out state" do
      expect(page).to have_content("Sign In")
    end

    scenario "doesn't show username on the homepage after logout" do
      fill_in 'Username', with: "brian"
      fill_in 'Password', with: "password"
      click_on "Log In"

      save_and_open_page
      click_on "Sign Out"

      expect(page).not_to have_content "brian"
    end
  end
end
