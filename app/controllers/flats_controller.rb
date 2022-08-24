class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @flats = Flat.all
    # @flats = Flat.geocoded
    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window: render_to_string(partial: "info_window", locals: {flat: flat}),
        image_url: helpers.asset_url("perfil.jpeg")
      }
    end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def show
    @flat = Flat.find(params[:id])
    @reservation = Reservation.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    authorize @flat
    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    redirect_to flats_path(@flat), status: :see_others
  end

  def my_flats
    @user = current_user
    @flats = Flat.where(user: @user)
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :address, :photo)
  end
end
