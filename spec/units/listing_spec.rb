# frozen_string_literal: true

require 'listing'

describe Listing do

    let(:listing_1) { Listing.create('Sea Cottage', 'Lovely holiday vacation', 23) }
    let(:listing_2) { Listing.create('Holiday house', 'Amazing location', 23) }

  describe '.create' do
    it 'should create a new listing with an id, title, description and creator_id' do

      expect(listing_1.first.id).to_not be nil
      expect(listing_1.first.title).to eq 'Sea Cottage'
      expect(listing_1.first.description).to eq 'Lovely holiday vacation'
      expect(listing_1.first.creator_id).to eq '23'
    end
  end

  describe '.all' do
    it 'should return all available listings' do
      listings = Listing.all

      expect(listings[0].title).to eq 'Ski lodge in South of France'
      expect(listings[1].title).to eq 'Holiday house'
      expect(listings[0].description).to eq 'Perfect for families'
      expect(listings[1].description).to eq 'Amazing location'
    end
  end

  describe '.book' do
    it 'should add listing to reserved when booked' do
      Listing.book(listing_1[0].id, 1)
      expect(Listing.reserved[0].renter_id).to eq '1'
      expect(Listing.all).to eq []
    end
  end
end
