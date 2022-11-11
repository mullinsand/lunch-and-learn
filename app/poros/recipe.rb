class Recipe
  attr_reader :title, :url, :country, :image

  def initialize(recipe, country)
    @title = recipe[:label]
    @url = recipe[:url]
    @image = recipe[:image]
    @country = country
  end
end