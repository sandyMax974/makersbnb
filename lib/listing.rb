# frozen_string_literal: true

class Listing
  attr_reader :id, :title, :description, :creator_id, :renter_id, :booking_date

  def initialize(input_hash)
    @id = input_hash[:id]
    @title = input_hash[:title]
    @description = input_hash[:description]
    @creator_id = input_hash[:creator_id]
    @renter_id = input_hash[:renter_id]
    @booking_date = input_hash[:booking_date]
  end

  def self.listing_to_array(results)
    results.map { |listing| Listing.new(listing) }
  end

  def self.create(title, description, creator_id, booking_date)
    results = query("INSERT INTO listings (title, description, creator_id, booking_date) VALUES('#{title}', '#{description}','#{creator_id}', '#{booking_date}') RETURNING id, title, description, creator_id, booking_date;")
    listing_to_array(results)
  end

  def self.all
    results = query('SELECT * FROM listings WHERE renter_id ISNULL;') # this is a hash
    listing_to_array(results) # this is an array w/ symbols
  end

  def self.reserved
    results = query('SELECT * FROM listings WHERE renter_id IS NOT NULL;') # this is a hash
    listing_to_array(results) # this is an array w/ symbols
  end

  def self.book(space_id, user_id)
    @user_id = user_id.to_i
    query("UPDATE listings SET renter_id = #{@user_id} WHERE id = #{space_id} RETURNING title;").last[:title] # this is a hash
  end

  private

  def self.query(sql)
    connection = PG.connect dbname: "makersbnb_#{ENV['RACK_ENV']}"
    results = connection.exec(sql)
    results.map { |result| result.transform_keys(&:to_sym) }
  end
end
