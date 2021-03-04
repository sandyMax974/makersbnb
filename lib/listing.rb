class Listing
  attr_reader :id, :title, :description, :creator_id

  def initialize(input_hash)
    @id = input_hash[:id]
    @title = input_hash[:title]
    @description = input_hash[:description]
    @creator_id = input_hash[:creator_id]
  end

  def self.create(title, description, creator_id)
    insertion = query("INSERT INTO listings (title, description, creator_id) VALUES('#{title}', '#{description}','#{creator_id}') RETURNING id, title, description, creator_id;")
    insertion.map { |listing| Listing.new(listing) }
  end

  def self.all
    results = query("SELECT * FROM listings WHERE renter_id ISNULL;") # this is a hash
    results.map { |listing| Listing.new(listing) } # this is an array w/ symbols
  end

  def self.reserved
    results = query("SELECT * FROM listings WHERE renter_id IS NOT NULL;") # this is a hash
  end

  def self.query(sql)
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    results = connection.exec(sql)
    results.map { |result| result.transform_keys(&:to_sym) }
  end

  def self.book(space_id, user_id)
    @user_id = user_id.to_i
    query("UPDATE listings SET renter_id = #{@user_id} WHERE id = #{space_id} RETURNING title;").last[:title] # this is a hash
  end

end
