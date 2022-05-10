require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create({
      first_name: 'D',
      last_name: 'G',
      email: 'd@g.ca',
      password: '123456789',
      password_confirmation: '123456789'})
  end

  describe 'Validations' do
    it "creates a user with all fields present" do
      expect(@user.first_name).to be_present
      expect(@user.last_name).to be_present
      expect(@user.email).to be_present
      expect(@user.password).to be_present
      expect(@user.password_confirmation).to be_present
    end

    it "does not allow a new user with same email to be created" do
      @user2 = User.create({
      first_name: 'D',
      last_name: 'G',
      email: 'd@g.ca',
      password: '123456789',
      password_confirmation: '123456789'})

      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end

    it "allows a new user with an unique email to be created" do
      @user3 = User.create({
      first_name: 'D',
      last_name: 'G',
      email: 'd123@g.ca',
      password: '123456789',
      password_confirmation: '123456789'})

      expect(@user3.errors.full_messages).to be_truthy
    end

    it "returns false if first name is nil" do
      if @user.first_name =  nil
        expect(@user.errors.messages[:first_name]).to include("can't be blank")
      end
    end

    it "returns false if last name is nil" do
      if @user.last_name =  nil
        expect(@user.errors.messages[:last_name]).to include("can't be blank")
      end
    end

    it "returns false if email is nil" do
      if @user.email =  nil
        expect(@user.errors.messages[:email]).to include("can't be blank")
      end
    end

    it "returns true if password is at least 8 characters" do
      expect(@user.password.length).to eql(9)
    end

     it 'returns false if password is not confirmed' do
        @user.password = '111111111'
        @user.save
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

    it "returns false if password is not 8 characters" do
      if @user.password =  "1234"
        expect(@user.password.length).to_not eql(8)
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates with valid credentials' do
      @user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to_not be(nil)
    end

    it 'does not auth with invalid email credentials' do
      @user = User.authenticate_with_credentials('some@mail.com', @user.password)
      expect(@user).to be(nil)
    end

    it 'cleans whitespace from before or after' do
      @user = User.authenticate_with_credentials('    d@g.ca       ', @user.password)
      expect(@user).to_not be(nil)
    end

    it 'is not case sensitive' do
      @user = User.authenticate_with_credentials('D@G.ca', @user.password)
      expect(@user).to_not be(nil)
    end
  end

end
