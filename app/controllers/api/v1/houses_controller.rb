class Api::V1::HousesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json

  def show
    respond_with House.find(params[:id])
  end

  def index
    respond_with House.all
  end

  def create
    house = current_user.houses.build(house_params)
    if house.save
      render json: house, status: 201, location: [:api, house]
    else
      render json: { errors: house.errors }, status: 422
    end
  end

  def update
    house = current_user.houses.find(params[:id])
    if house.update(house_params)
      render json: house, status: 200, location: [:api, house]
    else
      render json: { errors: house.errors }, status: 422
    end
  end

  def destroy
    house = current_user.houses.find(params[:id])
    house.destroy
    head 204
  end

  private

  def house_params
    params.require(:house).permit(:description, :price, :published, :latitude, :longitude)
  end
end
