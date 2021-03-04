require 'user'

describe User do

  describe '.create' do
    it 'should be able to create a user' do
      subject = User.create('pete', 'pete@example.com', '1234', '1234')
      expect(subject.name).to eq 'pete'
      expect(subject.email).to eq 'pete@example.com'
      expect(subject.password).to eq '1234'
    end

    it 'should raise error if passwords dont match' do
      expect { User.create('pete', 'pete@example.com', '1234', '1') }.to raise_error "Passwords should match"
    end

    it 'should encrypt the password' do
      encrypted_password = BCrypt::Password.create('1234')

      subject = User.create('pete', 'pete@example.com', '1234', '1234')
      result = User.query("SELECT * from users WHERE username = '#{subject.name}';")
      expect(result.first[:password]).not_to eq('1234')
    end
  end

  describe '.current' do
    it "should return current user's info" do
      subject = User.create('pete', 'pete@example.com', '1234', '1234')
      expect(User.current.name).to eq 'pete'
      expect(User.current.email).to eq 'pete@example.com'
      expect(User.current.password).to eq '1234'
    end
  end

  describe '.authenticate' do
    it 'returns a given user for a correct password and email, if one exist' do
      user = User.create('Sandy', 'sandy@gmail.com', '1234', '1234')
      authenticated_user = User.authenticate('sandy@gmail.com', '1234')

      expect(authenticated_user.user_id).to eq user.user_id
    end
    it 'returns nil if an incorrect email is suppplied' do
      user = User.create('Sandy', 'sandy@gmail.com', '1234', '1234')
      expect(User.authenticate('incorrect@gmail.com', '1234')).to be_nil
    end
    #   it 'returns nil if an incorrect password is suppplied' do
    #     user = User.create('Sandy', 'sandy@gmail.com', '1234', '1234')
    #     expect(User.authenticate('sandy@gmail.com', 'wrong')).to be_nil
    #   end
    end

  describe '.logout' do
    it 'logs out the current user' do
      user = User.create('Sandy', 'sandy@gmail.com', '1234', '1234')
      User.logout

      expect(User.current).to be nil
    end
  end

end
