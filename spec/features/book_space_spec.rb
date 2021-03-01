feature 'user books available space' do
  scenario 'user receives confirmation message' do
    visit '/'
    click_button('book space 1!')

    expect(current_path).to eq('/confirmation')

    expect(page).not_to have_content('You have booked space 2!')
    expect(page).not_to have_content('You have booked space 3!')
    expect(page).not_to have_content('You have booked space 4!')

    expect(page).to have_content('You have booked space 1!')
  end
  scenario 'booked space removed from listings view' do
    visit '/'
    click_button('book space 1!')
    click_link('View more spaces // go back to home page')

    expect(page).not_to have_content('space 1')
  end
end
