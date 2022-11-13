class LearningResourceFacade
  
  def self.generate_for(country)
    country_video = YoutubeFacade.video_about(country)
    country_images = UnsplashFacade.images_of(country)

    LearningResource.new(country, country_video, country_images)
  end
end