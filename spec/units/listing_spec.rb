# frozen_string_literal: true

require 'listing'

describe Listing do
  describe '.create' do
    it 'should create a new listing with an id, title, description and creator_id' do
      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 23, "2021-03-05")

      expect(listing.first.id).to_not be nil
      expect(listing.first.title).to eq 'Sea Cottage'
      expect(listing.first.description).to eq 'Lovely holiday vacation'
      expect(listing.first.creator_id).to eq '23'
      expect(listing.first.booking_date).to eq '2021-03-05'
    end
  end

  describe '.all' do
    it 'should return all available listings' do
      Listing.create('Ski lodge in South of France', 'Perfect for families', 2, "2021-03-05")
      Listing.create('Holiday house', 'Amazing location', 23, "2021-03-06")

      listings = Listing.all

      expect(listings[0].title).to eq 'Ski lodge in South of France'
      expect(listings[1].title).to eq 'Holiday house'
      expect(listings[0].description).to eq 'Perfect for families'
      expect(listings[1].description).to eq 'Amazing location'
      expect(listings[0].booking_date).to eq '2021-03-05'
      expect(listings[1].booking_date).to eq '2021-03-06'
    end
  end

  describe '.book' do
    it 'should add listing to reserved when booked' do
      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 23, "2021-03-05")
      Listing.book(listing[0].id, 1)
      expect(Listing.reserved[0].renter_id).to eq '1'
      expect(Listing.all).to eq []
    end
  end

end
