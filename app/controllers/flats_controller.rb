class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      # sql_query = "address ILIKE :query"
      # @flats = Flat.where(sql_query, query: "%#{params[:query]}%")

      @flats = policy_scope(Flat.search_by_address(params[:query]))
    else
      @flats = policy_scope(Flat)
      # @flats = Flat.all
    end

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


  def show
    @flat = Flat.find(params[:id])
    @reservation = Reservation.new
    authorize @flat
  end

  def new
    @flat = Flat.new
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


  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    authorize @flat
    if Flat.update(flat_params)
      redirect_to flat_path(@flat)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.destroy
    redirect_to flats_path, status: :see_other
  end

  def my_flats
    @user = current_user
    @flats = Flat.where(user: @user)
    authorize @flats
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :address, :photo)
  end
end
