require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should accept a user with all valid attiributes' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')
  
      expect(user).to be_valid
    end
  
    it 'shouldnt accept a user with non-matching passwords' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '4321')
  
      expect(user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end
  
    it 'shouldnt accept a user with no password' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: nil, password_confirmation: nil)
  
      expect(user.errors.full_messages[0]).to eq("Password can't be blank")
    end

    it 'shouldnt accept a password with less than 4 characters' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '12', password_confirmation: '12')
  
      expect(user.errors.full_messages[0]).to eq("Password is too short (minimum is 4 characters)")
    end 

    it 'cant create an account with an email that exists within the database (case sensitive = false)' do
      user_2 = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')

      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@TEST.com', password: '1234', password_confirmation: '1234')

      expect(user.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it 'is not valid without an email' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: nil, password: '1234', password_confirmation: '1234')
  
      expect(user.errors.full_messages[0]).to eq("Email can't be blank")
    end

    it 'is not valid without a first name' do
      user = User.create(first_name: nil, last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')
  
      expect(user.errors.full_messages[0]).to eq("First name can't be blank")
    end

    it 'is not valid without a first name' do
      user = User.create(first_name: 'Jon ', last_name: nil, email: 'test@test.com', password: '1234', password_confirmation: '1234')
  
      expect(user.errors.full_messages[0]).to eq("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user with proper credentials' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')

      expect(User.authenticate_with_credentials('test@test.com', '1234')).to eq(user)
    end

    it 'shouldnt return a user with wrong credentials' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')

      expect(User.authenticate_with_credentials('test@test.com', '4321')).not_to eq(user)
    end

    it 'should return a user with leading/trailing spaces in the email' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')

      expect(User.authenticate_with_credentials('  test@test.com  ', '1234')).to eq(user)
    end

    it 'should return a user even with capitalized letters in the email' do
      user = User.create(first_name: 'Jon', last_name: 'Doe', email: 'test@test.com', password: '1234', password_confirmation: '1234')

      expect(User.authenticate_with_credentials('test@tEsT.cOm', '1234')).to eq(user)
    end
  end
end
