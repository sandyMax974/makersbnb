require 'listing'

describe Listing do
  describe '.create' do
    it 'should create a new listing' do

      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 23)
      expect(listing.title).to eq 'Sea Cottage'
      expect(listing.description).to eq 'Lovely holiday vacation'
      expect(listing.creator_id).to eq 23
    end
  end

  describe '.all' do
    it 'should return all available listings' do
      Listing.create('Ski lodge in South of France', 'Perfect for families', 2)
      Listing.create('Holiday house', 'Amazing location', 23)

      listings = Listing.all

      expect(listings[0].title).to eq 'Ski lodge in South of France'
      expect(listings[1].title).to eq 'Holiday house'
    end
  end

  describe '.book' do
    it 'should remove listing from all when booked' do
      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 23)
      Listing.create('Ski lodge in South of France', 'Perfect for families', 2)
      Listing.book(listing.id, 1)
      p Listing.all
      p listing.renter_id
      expect(Listing.all[0].renter_id).to eq 1
    end
  end

end
