feature 'Authentication' do
  scenario 'A user ca sign in' do
    User.create('Sandy974','sandy@gmail.com','1234', '1234')

    visit('/login')
    fill_in('username', with: 'Sandy974')
    fill_in('password', with: '1234')
    click_button('Sign in')

    expect(page).to have_content("Hello Sandy974")
  end
end
