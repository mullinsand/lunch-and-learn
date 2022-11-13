class UnsplashFacade
  
  def self.images_of(country)
    image_results = UnsplashService.images_of(country)
    return image_results[:results] if image_results[:results] == []

    image_results[:results].map do |image_info|
      CountryImage.new(image_info)
    end
  end
end