class User

  attr_reader :username, :email, :password

  @current = ''

  def initialize(username, email, password1, password2)
    @username = username
    @email = email
    raise("Passwords should match") if password1 != password2
    @password = password1
  end

  def self.create(username, email, password1, password2)
    @current = User.new(username, email, password1, password2)
  end

  def self.current
    @current
  end

end
