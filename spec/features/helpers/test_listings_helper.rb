# frozen_string_literal: true

def create_test_listings
  Listing.create('Space 1', 'test', 1)
  Listing.create('Space 2', 'test', 2)
  Listing.create('Space 3', 'test', 3)
end
