# frozen_string_literal: true

require_relative 'sign_up_helper'

feature 'Add listings' do
  scenario 'User can add a listing' do
    sign_up
    visit '/spaces/new'
    fill_in('title', with: 'House 4')
    fill_in('description', with: 'House 4')

    click_button 'Add listing'
    expect(page).to have_content 'House 4'
  end
end
