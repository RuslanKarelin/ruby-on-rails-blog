require 'rails_helper'
require 'capybara/rspec'

feature "Signing in" do

  given(:user) { create(:user, email: 'userr@example.com', password: '111111') }

  scenario "Signing in with correct credentials" do
    login_user user: user, content: 'Signed in successfully.'
  end

  given(:other_user) { User.new(email: 'other@example.com', password: '111111') }

  scenario "Signing in as another user" do
    login_user user: other_user, content: 'Invalid Email or password'
  end
end

def login_user(options)
  visit new_user_session_path
  within("#log_in_form") do
    fill_in 'user_email', with: options[:user].email
    fill_in 'user_password', with: options[:user].password
  end
  click_button 'Log in'
  expect(page).to have_content options[:content]
end