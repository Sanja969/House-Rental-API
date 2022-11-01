class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]
  def index
    @reservations = Reservation.all
    render json: @reservations, status: :ok
  end

  def create
    @reservation = Reservation.create(reservation_params)
    if @reservation.save
      render json: @reservation, status: :ok
    else
      render json: { error: 'Reservation not denied' }, status: :unprocessable_entity
    end
  end

  def cancel_reservation
    @cancel = Reservation.find(params[:id])
    @cancel.destroy
    if @cancel.destroyed?
      render json: { message: 'Booking cancelled successfully.' }, status: :ok
    else
      render json: { message: 'Booking not cancelled.' }, status: :unprocessable_entity
    end
  end

  def reservation_params
    params.permit(:user_id, :house_id, :date, :city, :status)
  end
end
