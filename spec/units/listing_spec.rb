require 'listing'

describe Listing do
  describe '.create' do
    it 'should create a new listing' do
        
      listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 23)
      p ENV['RACK_ENV']
      expect(listing.title).to eq 'Sea Cottage'
      expect(listing.description).to eq 'Lovely holiday vacation'
      expect(listing.creator_id).to eq 23
    end
  end
end
