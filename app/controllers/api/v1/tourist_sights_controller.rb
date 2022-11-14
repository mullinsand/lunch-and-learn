class Api::V1::TouristSightsController < ApplicationController
  def index
    distance = 20_000
    # return country_not_found unless country_exists?
    if params[:country]
      tourist_sights = PlacesFacade.capital_tourist_sights(params[:country], distance)
    else
      country = RestCountriesFacade.random_country
      tourist_sights = PlacesFacade.capital_tourist_sights(country, distance)
    end
    tourist_sights == [] ? (render json: { data: [] }) : (render json: TouristSightSerializer.new(tourist_sights))
  end

  private

  # def country_exists?
  #   RestCountriesService.all_countries.map {|country| country[:name][:common].downcase }.include?(params[:country])
  # end
end