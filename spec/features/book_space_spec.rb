require_relative 'sign_up_helper'

feature 'book a space' do
  scenario 'receives confirmation message' do
    Listing.create('Space 1', 'test', 1)
    Listing.create('Space 2', 'test', 2)
    Listing.create('Space 3', 'test', 3)
    Listing.create('Space 4', 'test', 4)

    sign_up
    expect(current_path).to eq('/spaces')
    click_button('book Space 1')

    expect(current_path).to eq('/confirmation')

    expect(page).not_to have_content('You have booked Space 2!')
    expect(page).not_to have_content('You have booked Space 3!')
    expect(page).not_to have_content('You have booked Space 4!')

    expect(page).to have_content('You have booked Space 1!')
  end

  # scenario 'space removed from listings view' do
  #   sign_up
  #   visit '/spaces'
  #   click_button('book space 1')
  #   click_link('View more spaces // go back to home page')
  #
  #   expect(page).not_to have_content('space 1')
  # end
end
