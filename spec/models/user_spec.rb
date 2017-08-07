require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid with valid fields' do
    @user = User.new(first_name: 'test',
                     last_name: 'testington',
                     email: 'user@user.com',
                     password: 'password',
                     password_confirmation: 'password')
    expect(@user).to be_valid
  end

  it 'should not be valid without first_name' do
    @user = User.new(first_name: nil,
                     last_name: 'testington',
                     email: 'user@user.com',
                     password: 'password',
                     password_confirmation: 'password')
    expect(@user).to_not be_valid
  end

  it 'should not be valid without last_name' do
    @user = User.new(first_name: 'test',
                     last_name: nil,
                     email: 'user@user.com',
                     password: 'password',
                     password_confirmation: 'password')
    expect(@user).to_not be_valid
  end
end
