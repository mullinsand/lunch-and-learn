class RestCountriesFacade
  
  def self.random_country
    all_countries = RestCountriesFacade.all_countries
    all_countries.sample[:name][:common]
  end

  def self.all_countries
    RestCountriesService.all_countries
  end
end