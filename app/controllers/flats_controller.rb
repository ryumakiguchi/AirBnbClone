class FlatsController < ApplicationController
  def new
    @flat = Flat.new
  end

  def show
    @flat = Flat.find(params[:id])
    @reservation = Reservation.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @flats = Flat.all
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    redirect_to flats_path(@flat), status: :see_others
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :photo)
  end
end
