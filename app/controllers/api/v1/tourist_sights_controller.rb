class Api::V1::TouristSightsController < ApplicationController
  include ExceptionHandler
  include Response

  def index
    distance = 20_000
    
    if params[:country]
      return country_not_found unless country_exists?
      
      tourist_sights = PlacesFacade.capital_tourist_sights(params[:country], distance)
    else
      country = RestCountriesFacade.random_country
      tourist_sights = PlacesFacade.capital_tourist_sights(country, distance)
    end
    tourist_sights == [] ? (render json: { data: [] }) : (render json: TouristSightSerializer.new(tourist_sights))
  end

  private

  def country_exists?
    RestCountriesFacade.all_countries_names.include?(params[:country].downcase)
  end
end