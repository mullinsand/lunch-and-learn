class CountryImage
  attr_reader :alt_tag, :url

  def initialize(image_info)
    image_info[:alt_description] = image_info[:description] if image_info[:alt_description].nil?
    @alt_tag = image_info[:alt_description]
    @url = image_info[:urls][:regular]
  end
end