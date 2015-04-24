# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  username           :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @attr = {
      :username => "Utilisateur exemple",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create new User" do
    User.create!(@attr)
  end

  it "should require a username" do
    bad_guy = User.new(@attr.merge(:username => ""))
    expect(bad_guy).not_to be_valid
  end

  it "should require an email" do
    bad_guy = User.new(@attr.merge(:email => ""))
    expect(bad_guy).not_to be_valid
  end

  it "username length should should be <= 32" do
    long_name = "a" * 33
    bad_guy = User.new(@attr.merge(:username => long_name))
    expect(bad_guy).not_to be_valid
  end

  it "email should be valid" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  it "email should not be valid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      expect(invalid_email_user).not_to be_valid
    end
  end

  it "email should be unique" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "email should be unique (not case sensitive)" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  describe "password validations" do

    it "should require password" do
      expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).not_to be_valid
    end

    it "should require correct password_confirmation" do
      expect(User.new(@attr.merge(:password_confirmation => "invalid"))).not_to be_valid
    end

    it "should reject small password" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      expect(User.new(hash)).not_to be_valid
    end

    it "should reject long password" do
      long = "a" * 33
      hash = @attr.merge(:password => long, :password_confirmation => long)
      expect(User.new(hash)).not_to be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have encrypted password" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "should define encrypted password" do
      expect(@user.encrypted_password).not_to be_blank
    end

    describe "method has_password?" do

      it "she be true if passwords are same" do
        expect(@user.has_password?(@attr[:password])).to be_truthy
      end    

      it "she be false if passwords are not the same" do
        expect(@user.has_password?("invalide")).to be_falsey
      end 
    end

    describe "authenticate method" do

      it "should return nil if wrong email/password" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        expect(wrong_password_user).to be_nil
      end

      it "Should return nil if no user find" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        expect(nonexistent_user).to be_nil
      end

      it "should return user if good email/password" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        expect(matching_user).to eq(@user)
      end
    end
  end

end
