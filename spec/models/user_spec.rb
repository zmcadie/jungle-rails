require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
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
      expect(@user.errors.full_messages).to eql ["First name can't be blank"]
    end

    it 'should not be valid without last_name' do
      @user = User.new(first_name: 'test',
                       last_name: nil,
                       email: 'user@user.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Last name can't be blank"]
    end

    it 'should not be valid without email' do
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: nil,
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Email can't be blank"]
    end

    it 'should not be valid without password' do
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: 'user@user.com',
                       password: nil,
                       password_confirmation: 'password')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 8 characters)"]
    end

    it 'should not be valid without password' do
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: 'user@user.com',
                       password: 'password',
                       password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Password confirmation can't be blank"]
    end

    it 'should not be valid if password and password_confirmation don\'t match' do
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: 'user@user.com',
                       password: 'password',
                       password_confirmation: 'passphrase')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Password confirmation doesn't match Password"]
    end

    it 'should not be valid if password length is less than 8 characters' do
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: 'user@user.com',
                       password: 'pass',
                       password_confirmation: 'pass')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Password is too short (minimum is 8 characters)"]
    end

    it 'should not be valid with duplicate email (case insensitive)' do
      User.create!(first_name: 'test',
                   last_name: 'testington',
                   email: 'user1@user.com',
                   password: 'password',
                   password_confirmation: 'password')
      @user = User.new(first_name: 'test',
                       last_name: 'testington',
                       email: 'USER1@USER.COM',
                       password: 'password',
                       password_confirmation: 'password')

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eql ["Email has already been taken"]
    end
  end

  describe '.authenticate_with_credentials' do
    User.find_by_email('user2@user.com').destroy
    User.create!(first_name: 'test',
                         last_name: 'testington',
                         email: 'user2@user.com',
                         password: 'password',
                         password_confirmation: 'password')
    it 'should be valid when passed valid fields' do
      @user = User.find_by_email('user2@user.com')
      expect(User.authenticate_with_credentials('user2@user.com', 'password')).to eql @user
    end

    it 'should not be valid if given wrong password' do
      expect(User.authenticate_with_credentials('user2@user.com', 'notpassword')).to eql nil
    end

    it 'should not be valid if given wrong email' do
      expect(User.authenticate_with_credentials('notuser2@user.com', 'password')).to eql nil
    end
  end
end
