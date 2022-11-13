class YoutubeFacade
  
  def self.video_about(country)
    video_results = YoutubeService.video_about(country)
    return video_results[:items] if video_results[:items] == []

    video_info = video_results[:items].first
    CountryVideo.new(video_info)
  end
end