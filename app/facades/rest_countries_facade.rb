class RestCountriesFacade
  
  def self.random_country
    all_countries = RestCountriesFacade.all_countries_names
    all_countries.sample
  end

  def self.all_countries
    RestCountriesService.all_countries
  end

  def self.all_countries_names
    RestCountriesService.all_countries.map { |country| country[:name][:common].downcase }
  end

  def self.capital_lat_long(country)
    capital_info = RestCountriesService.capital_info(country)
    {
      lat: capital_info[0][:capitalInfo][:latlng][0],
      long: capital_info[0][:capitalInfo][:latlng][1]
    }
  end
end