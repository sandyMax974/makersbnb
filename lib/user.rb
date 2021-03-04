# frozen_string_literal: true

require 'pg'
require 'bcrypt'

class User
  attr_reader :user_id, :name, :email, :password

  def initialize(user_id, name, email, password, confirm_password)
    @user_id = user_id
    @name = name
    @email = email
    raise('Passwords should match') if password != confirm_password

    @password = password
  end

  def self.create(name, email, password, confirm_password)
    encrypted_password = BCrypt::Password.create(password)
    user_id = query("INSERT INTO users (username, email, password) VALUES('#{name}', '#{email}', '#{encrypted_password}') RETURNING id;")
    @current = User.new(user_id, name, email, password, confirm_password)
  end

  class << self
    attr_reader :current
  end

  def self.query(query_string)
    @dbname = ENV['ENVIRONMENT'] == 'test' ? 'makersbnb_test' : 'makersbnb_development'
    results = PG.connect(dbname: @dbname).exec(query_string)
    results.map { |result| result.transform_keys(&:to_sym) }
  end
end
