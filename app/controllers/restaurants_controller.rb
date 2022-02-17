class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = 'Restaurant has been added to the API'
      redirect_to [current_user, @restaurant]
    else
      flash.now[:alert] = 'Restaurant has not been created'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = 'Restaurant has been updated to the API'
      redirect_to [current_user, @restaurant]
    else
      flash.now[:alert] = 'restaurant has not been updated'
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    flash[:notice] = 'Restaurant has been Removed from the Api'
    redirect_to user_restaurants_path(current_user)
  end
  private

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :user_id)
  end
end
