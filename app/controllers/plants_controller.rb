class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end
  def update
    plant = find
    if plant.update(plant_params)
      render json: plant, status: 204
    else
      render json: {error: "Not Updated"}
    end
  end
  def destroy
    plant = find
    if plant.destroy
      head :no_content
    else
      render json: {error: "Could Not Delete"}
    end
  end

  private
  def find
    Plant.find(params[:id])
  end
  def render_not_found_response
    render json: {error: "Plant Not Found"}, status: :not_found
  end
  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
