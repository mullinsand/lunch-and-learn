class RestCountriesService
  
  def self.conn
    Faraday.new("https://restcountries.com")
  end
  
  def self.all_countries
    response = conn.get('/v3.1/all') do |f|
      f.params[:fields] = 'name'
    end
    parse(response.body)
  end

  def self.capital_info(country)
    country.gsub!(" ", "%20") if country.include?(" ")
    response = conn.get("/v3.1/name/#{country}") do |f|
      f.params[:fields] = 'capitalInfo'
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end