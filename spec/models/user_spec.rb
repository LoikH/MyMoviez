# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @attr = { :username => "Example User", :email => "user@example.com" }
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
end
