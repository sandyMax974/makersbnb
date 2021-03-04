# frozen_string_literal: true

class Listing
  attr_reader :id, :title, :description, :creator_id

  def initialize(id = 3, title, description, creator_id)
    @id = id
    @title = title
    @description = description
    @creator_id = creator_id
  end

  def self.create(title, description, creator_id)
    insertion = query("INSERT INTO listings (title, description, creator_id) VALUES('#{title}', '#{description}','#{creator_id}') RETURNING id, title, description, creator_id;")
    insertion.map { |listing| Listing.new(listing[:id], listing[:title], listing[:description], listing[:creator_id]) }
  end

  def self.all
    results = query('SELECT * FROM listings WHERE renter_id ISNULL;') # this is a hash
    results.map { |row| Listing.new(row[:title], row[:description], row[:creator_id]) } # this is an array w/ symbols
  end

  def self.query(sql)
    connection = PG.connect dbname: "makersbnb_#{ENV['RACK_ENV']}"
    results = connection.exec(sql)
    results.map { |result| result.transform_keys(&:to_sym) }
  end
end
