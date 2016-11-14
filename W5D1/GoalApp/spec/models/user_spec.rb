require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) do
    FactoryGirl.build(:user)
  end

  describe "password encryption" do
    it "does not save passwords to the database" do
      User.create!(username: "Joe_Blow", password:"password")
      user = User.find_by_username("Joe_Blow")
      expect(user.password).not_to be("password")
    end

    it "encrypts the password using Bcrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "Brian", password: "password")
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
end
