class HousesController < ApplicationController
  before_action :set_house, only: %i[show update destroy]

  # GET /houses
  def index
    @houses = House.all

    render json: @houses
  end

  # GET /houses/1
  def show
    render json: @house
  end

  # POST /houses
  def create
    @house = User.find_by(role: 'admin').houses.new(house_params)

    if @house.save
      render json: @house, status: :created, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1
  def update
    if @house.update(house_params)
      render json: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # DELETE /houses/1
  def destroy
    @house.reservations.each(&:destroy)
    @house.destroy
    @houses = House.all
    render json: @houses, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.permit(:name, :image_data, :description, :price, :user_id, :city, :adress, :available)
  end
end
