require 'user'

describe User do

  it 'should be able to create a user' do
    subject = User.create('pete', 'pete@example.com', '1234', '1234')
    expect(subject.name).to eq 'pete'
    expect(subject.email).to eq 'pete@example.com'
    expect(subject.password).to eq '1234'
  end

  it 'should raise error if passwords dont match' do
    expect { User.create('pete', 'pete@example.com', '1234', '1') }.to raise_error "Passwords should match"
  end

  it "should return current user's info" do
    subject = User.create('pete', 'pete@example.com', '1234', '1234')
    expect(User.current.name).to eq 'pete'
    expect(User.current.email).to eq 'pete@example.com'
    expect(User.current.password).to eq '1234'
  end

end
