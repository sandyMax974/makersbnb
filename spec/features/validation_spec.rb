# frozen_string_literal: true

require_relative './helpers/log_in_helper'

feature 'Validation' do
  scenario 'A user can log in' do
    log_in
    expect(page).to have_content('Hello Sandy974')
  end

  scenario 'A user can log out' do
    log_in
    expect(page).to have_content('Hello Sandy974')

    click_button('Sign Out')

    expect(page).to_not have_content('Hello Sandy974')
  end
end
