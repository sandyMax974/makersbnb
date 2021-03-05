# frozen_string_literal: true

require_relative './helpers/sign_up_helper'
require_relative './helpers/test_listings_helper'

feature 'book a space' do
  before :each do
    create_test_listings
    sign_up
  end

  scenario 'receives confirmation message' do
    expect(current_path).to eq('/spaces')
    click_button('book Space 1')

    expect(page).not_to have_content('You have booked Space 2!')
    expect(page).not_to have_content('You have booked Space 3!')
    expect(page).not_to have_content('You have booked Space 4!')

    expect(page).to have_content('You have booked Space 1!')
  end

  scenario 'space removed from listings view' do
    visit '/spaces'
    click_button('book Space 1')
    click_link('View more spaces')

    expect(page).not_to have_content('Space 1')
  end
end
