class LearningResource
  attr_reader :video, :images, :country, :id

  def initialize(country, country_video, country_images)
    @video = country_video
    @images = country_images
    @country = country
    @id = nil
  end
end