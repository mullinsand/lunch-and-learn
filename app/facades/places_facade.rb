class PlacesFacade
  
  def self.capital_tourist_sights(country, distance)
    capital_info = RestCountriesFacade.capital_lat_long(country)
    tourist_sights = PlacesService.capital_tourist_sights(capital_info, distance)
    tourist_sights[:features].map { |tourist_sight_info| TouristSight.new(tourist_sight_info) }
  end
end