# frozen_string_literal: true

require 'user'

describe User do
  let(:user) { User.create('pete', 'pete@example.com', '1234', '1234') }

  describe '.create' do
    it 'should be able to create a user' do
      expect(user.name).to eq 'pete'
      expect(user.email).to eq 'pete@example.com'
      expect(user.password).to eq '1234'
    end

    it 'should raise an error if passwords dont match' do
      expect { User.create('pete', 'pete@example.com', '1234', '1') }.to raise_error 'Passwords should match'
    end

    it 'should encrypt the password' do
      BCrypt::Password.create('1234')
      result = User.query("SELECT * from users WHERE username = '#{user.name}';")
      expect(result.first[:password]).not_to eq('1234')
    end
  end

  describe '.current' do
    it "should return current user's info" do
      expect(User.current.name).to eq 'pete'
      expect(User.current.email).to eq 'pete@example.com'
      expect(User.current.password).to eq '1234'
    end
  end

  describe '.validate' do
    it 'returns a given user for a correct password and email, if one exists' do
      validated_user = User.validate('pete@example.com', '1234')
      p validated_user
      expect(validated_user.user_id).to eq User.user_id
    end

    it 'returns nil if an incorrect email is suppplied' do
      expect(User.validate('incorrect@gmail.com', '1234')).to be_nil
    end

    it 'returns nil if an incorrect password is suppplied' do
      expect(User.validate('pete@example.com', 'wrong')).to be_nil
    end
  end

  describe '.logout' do
    it 'logs current user out' do
      User.logout
      expect(User.current).to be nil
    end
  end
end
