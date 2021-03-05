# frozen_string_literal: true

def create_test_listings
  Listing.create('Space 1', 'test', 1, '2021-03-05')
  Listing.create('Space 2', 'test', 2, '2021-03-06')
  Listing.create('Space 3', 'test', 3, '2021-03-07')
end
