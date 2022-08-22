class FlatsController < ApplicationController
  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flats_paths
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @flats = Flat.all
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :rating, :photo)
  end
end
