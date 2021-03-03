require_relative 'sign_up_helper'

feature 'sign up for makers bnb' do
  scenario 'user can register' do
    sign_up
    expect(page).to have_content("Hello Pete")
    expect(current_path).to eq '/spaces'
  end

  scenario 'email must be a valid email' do
    visit '/'
    fill_in('username', with: 'Pete')
    fill_in('email', with: 'Pete')
    fill_in('password', with: '1234')
    fill_in('confirm_password', with: '1234')
    click_button 'Submit'

    expect(current_path).to eq '/'
    expect(page).to have_content("You must submit a valid email")
  end

  # scenario 'password must match confirm_password' do
  #
  # end
end
