require 'rails_helper'

describe User do

  before do
    @params = { :email  => 'test@tester.test', :password => 'password', :password_confirmation => 'password' }
  end

  it 'requires a valid email address' do
    user = User.new(@params.merge(:email => 'invalid'))
    expect(user).to_not be_valid
  end

  it 'requires a unique email address' do
    user = User.create(@params)
    duplicate_user = User.new(@params)
    expect(duplicate_user).to_not be_valid
    user.destroy!
  end

  it 'requires a matching password confirmation on create' do
    user = User.create(@params.merge(:password_confirmation => 'abc'))
    expect(user).to_not be_valid
  end

  it 'allows a blank password confirmation on create' do
    @params.delete(:password_confirmation)
    user = User.create(@params)
    expect(user).to be_valid
    user.destroy!
  end

  it 'encrypts password on creation' do
    user = User.create(@params)
    expect(user.password_digest).to_not eql(@params[:password])
    expect(user.password_digest.length).to eql(60)
    user.destroy!
  end

end