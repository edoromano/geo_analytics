require 'spec_helper'

describe Api::V1::HousesController do
  describe "GET #show" do
    before(:each) do
      @house = FactoryGirl.create :house
      get :show, id: @house.id
    end

    it "returns the information about a reporter on a hash" do
      house_response = json_response
      expect(house_response[:description]).to eql @house.description
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :house }
      get :index
    end

    it "returns 4 records from the database" do
      houses_response = json_response
      expect(houses_response[:houses]).to have(4)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @house_attributes = FactoryGirl.attributes_for :house
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, house: @house_attributes }
      end

      it "renders the json representation for the house record just created" do
        house_response = json_response
        expect(house_response[:description]).to eql @house_attributes[:description]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_house_attributes = { description: "Smart TV", price: "Twelve dollars" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, house: @invalid_house_attributes }
      end

      it "renders an errors json" do
        house_response = json_response
        expect(house_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        house_response = json_response
        expect(house_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @house = FactoryGirl.create :house, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        put :update, { user_id: @user.id, id: @house.id,
                         house: { description: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        house_response = json_response
        expect(house_response[:description]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        put :update, { user_id: @user.id, id: @house.id,
                         house: { price: "two hundred" } }
      end

      it "renders an errors json" do
        house_response = json_response
        expect(house_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        house_response = json_response
        expect(house_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @house = FactoryGirl.create :house, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @house.id }
    end

    it { should respond_with 204 }
  end
end
