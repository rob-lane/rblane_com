require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_params = {email: 'test@rblane.com', password: 'password', password_confirmation: 'password'}
  end

  test 'Requires a valid email' do
    user = User.new(@user_params.merge(email: 'invalid'))
    assert_not(user.valid?, 'User with invalid email address should not be valid')
  end

  test 'Requires a unique email' do
    user = User.create(@user_params)
    duplicate_user = User.new(@user_params)
    assert_not(duplicate_user.valid?, 'User with duplicate email address should not be valid')
    user.destroy
  end

  test 'Requires a matching password confirmation to create' do
    user = User.create(@user_params.merge(password_confirmation: ('abc123')))
    assert_not(user.valid?, 'User created without a matching password confirmation should not be valid')
  end

  test 'Allows a blank password confirmation on creation' do
    @user_params.delete(:password_confirmation)
    user = User.create(@user_params)
    assert(user.valid?, 'User created with a blank password confirmation should be valid')
    user.destroy
  end

  test 'Password is encrypted to a digest field' do
    # Not going to test bcrypt, just that the value is not equal and of appropriate length
    user = User.create(@user_params)
    assert_not_equal(user.password_digest, @user_params[:password])
    assert_equal(user.password_digest.length, 60)
    user.destroy
  end
end
