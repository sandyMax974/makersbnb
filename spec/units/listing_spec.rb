require 'listing'

describe Listing do
  describe '.create' do
    it 'should create a new listing' do
        
      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 'test123')

      expect(listing.title).to eq 'Sea Cottage'
      expect(listing.description).to eq 'Lovely holiday vacation'
      expect(listing.user).to eq 'test123'
    end
  end
end
