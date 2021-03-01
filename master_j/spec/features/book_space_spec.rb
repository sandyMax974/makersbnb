feature 'book a space' do
  scenario 'user books available space, receives confirmation message' do
    visit '/'
    click_button('book space 1!')

    expect(current_path).to eq('/confirmation')

    expect(page).not_to have_content('You have booked space 2!')
    expect(page).not_to have_content('You have booked space 3!')
    expect(page).not_to have_content('You have booked space 4!')

    expect(page).to have_content('You have booked space 1!')
  end
end
