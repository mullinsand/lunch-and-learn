class CountryImage
  attr_reader :alt_tag, :url

  def initialize(image_info)
    @alt_tag = image_info[:alt_description]
    @url = image_info[:urls][:regular]
  end
end