class Listing

  def self.create(title, description, creator_id)
    connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    insert = connection.exec("INSERT INTO listings (title, description, creator_id) VALUES('#{title}', '#{description}','#{creator_id}') RETURNING id, title, description, creator_id")
    Listing.new(title, description, creator_id)
  end

  attr_reader :title, :description, :creator_id

  def initialize(id = 'id', title, description, creator_id)
    @id = id
    @title = title
    @description = description
    @creator_id = creator_id
  end

end
