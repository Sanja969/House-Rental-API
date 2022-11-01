class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]
  def index
    @reservations = Reservation.all
    render json: @reservations, status: :ok
  end

  def create
      # rubocop:todo Layout/IndentationWidth
      @reservation = Reservation.create(status: 'pending', user_id: params[:user_id], house_id: params[:house_id],
                                        date: params[:date])
      # rubocop:enable Layout/IndentationWidth
      render json: @reservation, status: :ok

      if @reservation.save
          render json: @reservation, status: :ok # rubocop:todo Layout/IndentationWidth
      else
        render json: { error: 'Reservation not denied' }, status: :unprocessable_entity
      end
  end

  def cancel_reservation
      @cancel = Reservation.find(params[:id]) # rubocop:todo Layout/IndentationWidth
      @cancel.destroy
      if @cancel.destroyed?
        render json: { message: 'Booking cancelled successfully.' }, status: :ok
      else
        render json: { message: 'Booking not cancelled.' }, status: :unprocessable_entity
      end
  end
end
