class PlacesService

  def self.conn
    Faraday.new("https://api.geoapify.com") do |f|
      f.params[:apiKey] = ENV['PLACES_KEY']
    end
  end

  def self.capital_tourist_sights(capital_info, distance)
    response = conn.get('/v2/places') do |f|
      f.params[:filter] = "circle:#{capital_info[:long]},#{capital_info[:lat]},#{distance}"
      f.params[:categories] = 'tourism.sights'
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end