class ReservationsController < ApplicationController

    def index
      @reservations = Reservation.all
    end

    def create
        @reservation = Reservation.create( status: 'pending' , user_id: params[:user_id], house_id: params[:house_id], date: params[:date])
        render json: @reservation, status: :ok
      
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
end