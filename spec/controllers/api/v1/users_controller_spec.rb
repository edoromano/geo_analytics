require 'spec_helper'

describe Api::V1::UsersController do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end
    end

    describe "PUT/PATCH #update" do
      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do
        before(:each) do
          @user = FactoryGirl.create :user
          patch :update, { id: @user.id,
                           user: { email: "newmail@example.com" } }, format: :json
        end

        it "renders the json representation for the updated user" do
          user_response = json_response
          expect(user_response[:email]).to eql "newmail@example.com"
        end

      end

      context "when is not created" do
        before(:each) do
          @user = FactoryGirl.create :user
          patch :update, { id: @user.id,
                           user: { email: "bademail.com" } }, format: :json
        end

        it "renders an errors json" do
          user_response = json_response
          expect(user_response).to have_key(:errors)
        end

        it "renders the json errors on whye the user could not be created" do
          user_response = json_response
          expect(user_response[:errors][:email]).to include "is invalid"
        end

      end
    end

    describe "DELETE #destroy" do
      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @user.id }, format: :json
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
  end
end
