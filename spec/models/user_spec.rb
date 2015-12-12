require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  # Shoulda tests for username

  # it { should validate_presence_of(:username) }
  # Shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value("user@bloccit.com").for(:email) }
  it { should_not allow_value("userbloccit.com").for(:email) }
  # Shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8) }

  describe "attributes" do
    it "should respond to email" do
      expect(user).to respond_to(:email)
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_username) { User.new(username: "", email: "user@blocmarks.com") }
    let(:user_with_invalid_email) { User.new(username: "Blocmarks User", email: "") }
    let(:user_with_invalid_email_format) { User.new(username: "Blocmarks User", email: "invalid_format") }

    it "should be an invalid user due to blank username" do
      expect(user_with_invalid_username).to_not be_valid
    end
    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
    it "should be an invalid user due to incorrectly formatted email address" do
      expect(user_with_invalid_email_format).to_not be_valid
    end
  end
end
