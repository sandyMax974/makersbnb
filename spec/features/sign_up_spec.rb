require_relative 'sign_up_helper'

feature 'sign up for makers bnb' do
  scenario 'user can register' do
    sign_up
    expect(page).to have_content("Hello Pete")
    expect(current_path).to eq '/spaces'
  end
end
