feature 'Browse listings' do
  scenario 'User can see a list of listings' do
    Listing.create('Space 1', 'test', 1)
    Listing.create('Space 2', 'test', 2)
    Listing.create('Space 3', 'test', 3)

    visit '/spaces'

    expect(page).to have_content 'Space 1'
    expect(page).to have_content 'Space 2'
    expect(page).to have_content 'Space 3'
  end
end
