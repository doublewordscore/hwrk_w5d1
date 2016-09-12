require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do
  subject(:user) do
    FactoryGirl.build(:user, name: "phil", password: "password123")
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6)}

  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:subs) }

  it "creates a password digest when password is input" do
    expect(user.password_digest).to_not be_nil
  end

  it "creates a session token before validation" do
    expect(user.session_token).to_not be_nil
  end

  describe "#reset_session_token!" do
    it "sets a new session token" do
      user.valid?
      prev = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(prev)
    end
  end

  describe "#is_password?" do
    it "has correct password" do
      expect(user.is_password?("password123")).to be true
    end

    it "says bad password is incorrect" do
      expect(user.is_password?("wrong")).to be false
    end

    describe "self.find_by_credentials" do
      it "returns correct user" do
        expect(User.find_by_credentials("phil", "password123")).to eq(user)
      end
    end
  end
end
