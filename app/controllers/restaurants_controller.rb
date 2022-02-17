class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def index
    @restaurant = Restaurant.all
  end

  def new
  end

  def create
  end

  def show
  end

  def update

  end

  def destroy
  end
end
