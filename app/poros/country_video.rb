class CountryVideo
  attr_reader :title, :video_id

  def initialize(video_info)
    @video_id = video_info[:id][:videoId]
    @title = video_info[:snippet][:title]
  end
end