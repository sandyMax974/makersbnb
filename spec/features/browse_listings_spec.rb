# frozen_string_literal: true

feature 'Browse listings' do
  scenario 'User can see a list of listings' do
    create_test_listings

    visit '/spaces'

    expect(page).to have_content 'Space 1'
    expect(page).to have_content 'Space 2'
    expect(page).to have_content 'Space 3'
  end
end
