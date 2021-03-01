feature 'sign up for makers bnb' do
  scenario 'user can register' do
    visit '/'
    fill_in('username', with: 'Pete')
    fill_in('email', with: 'pete@pete.com')
    fill_in('password', with: '1234')
    fill_in('confirm_password', with: '1234')
    click_button 'Submit'
    expect(page).to have_content("Hello Pete")
    expect(current_path).to eq '/spaces'
  end
end