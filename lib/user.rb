require 'pg'
require 'bcrypt'

class User

  attr_reader :name, :email, :password

  def initialize(name, email, password, confirm_password)
    @name = name
    @email = email
    raise("Passwords should match") if password != confirm_password
    @password = password
  end

  def self.create(name, email, password, confirm_password)
    encrypted_password = BCrypt::Password.create(password)
    query("INSERT INTO users (username, email, password) VALUES('#{name}', '#{email}', '#{encrypted_password}');")
    @current = User.new(name, email, password, confirm_password)
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
