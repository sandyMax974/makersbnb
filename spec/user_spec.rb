# frozen_string_literal: true

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
      expect { User.create('pete', 'pete@example.com', '1234', '1') }.to raise_error 'Passwords should match'
    end

    it 'should encrypt the password' do
      BCrypt::Password.create('1234')

      subject = User.create('pete', 'pete@example.com', '1234', '1234')
      result = User.query("SELECT * from users WHERE username = '#{subject.name}';")
      expect(result.first[:password]).not_to eq('1234')
    end
  end

  describe '.current' do
    it "should return current user's info" do
      User.create('pete', 'pete@example.com', '1234', '1234')
      expect(User.current.name).to eq 'pete'
      expect(User.current.email).to eq 'pete@example.com'
      expect(User.current.password).to eq '1234'
    end
  end
end
