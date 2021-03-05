# frozen_string_literal: true

def log_in
  User.create('Sandy974', 'sandy@gmail.com', '1234', '1234')

  visit('/login')
  fill_in('email', with: 'sandy@gmail.com')
  fill_in('password', with: '1234')
  click_button('Sign in')
end
