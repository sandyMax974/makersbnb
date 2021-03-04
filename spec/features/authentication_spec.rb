feature 'Authentication' do
  scenario 'A user can sign in' do
    User.create('Sandy974','sandy@gmail.com','1234', '1234')

    visit('/login')
    fill_in('email', with: 'sandy@gmail.com')
    fill_in('password', with: '1234')
    click_button('Sign in')
    expect(page).to have_content("Hello Sandy974")
  end

  scenario 'A user can sign out' do
    User.create('Sandy974','sandy@gmail.com','1234', '1234')

    visit('/login')
    fill_in('email', with: 'sandy@gmail.com')
    fill_in('password', with: '1234')
    click_button('Sign in')
    expect(page).to have_content("Hello Sandy974")

    click_button('Signout')

    expect(page).to_not have_content("Hello Sandy974")
  end
end
