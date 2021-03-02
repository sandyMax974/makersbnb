feature 'Browse listings' do
  scenario 'User can see a list of listings' do

    visit '/spaces'

    expect(page).to have_content 'House 1'
    expect(page).to have_content 'House 2'
    expect(page).to have_content 'House 3'
  end
end
