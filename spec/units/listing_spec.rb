require 'listing'

describe Listing do
  describe '.create' do

    listing = Listing.create('Sea Cottage', 'Lovely holiday vacation', 'test123')

    expect(listing.title).to eq 'Sea Cottage'
    expect(listing.description).to eq 'Lovely holiday vacation'
    expect(listing.creator_id).to eq 'test123'
  end
end
