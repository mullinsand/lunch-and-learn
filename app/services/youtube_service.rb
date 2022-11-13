class YoutubeService
  
  def self.conn
    Faraday.new('https://www.googleapis.com') do |f|
      f.params[:key] = ENV['YOUTUBE_KEY']
    end
  end
  
  def self.video_about(country)
    response = conn.get('/youtube/v3/search') do |f|
      f.params[:q] = country
      f.params[:part] = 'snippet'
      # Mr History's channel ID
      f.params[:channelId] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end