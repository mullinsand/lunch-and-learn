class RestCountriesService
  
  def self.conn
    Faraday.new('https://restcountries.com/v3.1/all')
  end
  
  def self.all_countries
    response = conn.get do |f|
      f.params[:fields] = 'name'
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end