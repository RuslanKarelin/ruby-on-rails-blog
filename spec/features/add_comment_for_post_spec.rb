require 'rails_helper'

feature "add comment for post" do

  given(:user) { create(:user, email: 'userr@example.com', password: '111111') }

  scenario "adding comments by an authorized user" do
    visit new_user_session_path
    within("#log_in_form") do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end
    click_button 'Log in'
    adding_comment true
  end

  scenario "adding comments by an not authorized user" do
    adding_comment
  end
end

def adding_comment(authorized = false)
  category = create(:category)
  category.posts << create(:post, category_id: category.id, category_ids: [category.id])
  post = category.posts.first
  visit post_path(category_alias: category.alias, post_alias: post.alias)
  within("form.post-reply") do
    fill_in 'comment_body', with: 'new comment by test'
    fill_in 'author_name', with: 'author name by test' unless authorized
  end
  click_button 'Submit'
  expect(page).to have_content 'new comment by test'
end