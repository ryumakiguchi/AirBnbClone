class ReservationsController < ApplicationController
  def index
    @user = current_user
    @reservations = Reservation.where(user: @user)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @flat = Flat.find(params[:flat_id])
    @reservation.flat = @flat
    if @reservation.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    redirect_to reservations_path(@reservation)
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path(@reservation), status: :see_other
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end
end
