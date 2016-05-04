require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }
  it { expect respond_to(:email) }
  it { expect respond_to(:password) }
  it { expect respond_to(:password_confirmation) }
  it { expect respond_to(:auth_token) }

  it { expect be_valid }
  it { should have_many(:houses) }

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "#houses association" do

    before do
      @user.save
      3.times { FactoryGirl.create :house, user: @user }
    end

    it "destroys the associated houses on self destruct" do
      houses = @user.houses
      @user.destroy
      houses.each do |house|
        expect(House.find(house)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
