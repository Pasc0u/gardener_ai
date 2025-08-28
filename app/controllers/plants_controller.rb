class PlantsController < ApplicationController

  def index
    @plants = current_user.plants
    @garden_name = current_user.garden
  end

  def show
    @plant = Plant.find(params[:id])
    @chat = Chat.new
    @chats = Chat.all
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(plant_params)
      redirect_to plant_path(@plant)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path, status: :see_other
  end

  private

  def plant_params
    params.require(:plant).permit(:nickname, :species, :image, :age, :is_potted, :location)
  end
end
