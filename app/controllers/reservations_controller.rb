class ReservationsController < ApplicationController

    def index
      @reservations = Reservation.all
    end

    def create
        # @user = current_user
        # @reservation = Reservation.create(price: params[:price], status: 'pending' , user_id: @user.id)
        # render json: @reservation, status: :ok
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          @reservation = Reservation.create( status: 'pending' , user_id: @user.id)
          
            render json: @reservation, status: :ok
        
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
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