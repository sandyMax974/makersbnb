require 'pg'

class User

  attr_reader :user_id, :name, :email, :password

  def initialize(user_id, name, email, password, confirm_password)
    @user_id = user_id
    @name = name
    @email = email
    raise("Passwords should match") if password != confirm_password
    @password = password
  end

  def self.create(name, email, password, confirm_password)
    user_id = query("INSERT INTO users (username, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING id;")
    @current = User.new(user_id, name, email, password, confirm_password)
  end

  def self.current
    @current
  end

  def self.query(query_string)
    ENV['ENVIRONMENT'] == 'test' ? @dbname = 'makersbnb_test' : @dbname = 'makersbnb_development'
    results = PG.connect(dbname: @dbname).exec(query_string)
    results.map { |result| result.transform_keys(&:to_sym) }
  end

end
