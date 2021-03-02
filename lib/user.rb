class User

  attr_reader :name, :email, :password

  def initialize(name, email, password1, password2)
    @name = name
    @email = email
    raise("Passwords should match") if password1 != password2
    @password = password1
  end

  def self.create(name, email, password1, password2)
    @current = User.new(name, email, password1, password2)
  end

  def self.current
    @current
  end

end
