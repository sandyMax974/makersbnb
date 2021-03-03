class Listing
  attr_reader :title, :description, :creator_id

  def initialize(id = 3, title, description, creator_id)
    @id = id
    @title = title
    @description = description
    @creator_id = creator_id
  end

  def self.create(title, description, creator_id)
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    insert = connection.exec("INSERT INTO listings (title, description, creator_id) VALUES('#{title}', '#{description}','#{creator_id}')")
    Listing.new(title, description, creator_id)
  end

  def self.all
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    query = connection.exec("SELECT * FROM listings WHERE renter_id ISNULL;")
    query.map { |row| Listing.new(row['id'], row['title'], row['description'], row['creator_id']) }
  end
end
