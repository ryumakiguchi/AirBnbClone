class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[edit update destroy]
  def index
    @user = current_user
    @reservations = Reservation.where(user: @user)
    @reservations = policy_scope(Reservation)
    @reservations.map do |reservation|
      flat = reservation.flat
      @markers = [
        {
          lat: flat.latitude,
          lng: flat.longitude,
          # info_window: render_to_string(partial: "info_window", locals: { flat: flat }),
          image_url: helpers.asset_url("perfil.jpeg")
        }]
    end
  end

  def new
    @reservation = Reservation.new
    authorize @reservation
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @flat = Flat.find(params[:flat_id])
    @reservation.flat = @flat
    authorize @reservation
    if @reservation.save
      redirect_to reservations_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @reservation.update(reservation_params)
    redirect_to reservations_path(@reservation)
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path(@reservation), status: :see_other
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end
end
