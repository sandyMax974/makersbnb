class Listing

  def self.create(title, description, user)
    # connection = PG.connect :dbname => "makersbnb_#{ENV['RACK_ENV']}"
    # insert = connection.exec("INSERT INTO listings (title, description, user) VALUES('#{title}', '#{description}','#{user}') RETURNING id, title, description, user")
    Listing.new(title, description, user)
  end

  attr_reader :title, :description, :user

  def initialize(id = 'id', title, description, user)
    @id = id
    @title = title
    @description = description
    @user = user
  end

end
