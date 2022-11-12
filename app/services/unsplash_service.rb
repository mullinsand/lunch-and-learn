class UnsplashService
  
  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params[:client_id] = ENV['UNSPLASH_KEY']
    end
  end
  
  def self.images_of(country)
    response = conn.get('/search/photos') do |f|
      f.params[:query] = country
      f.headers['X-Per-Page'] = '10'
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end