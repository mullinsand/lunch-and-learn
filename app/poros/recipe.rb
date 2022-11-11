class Recipe
  attr_reader :title, :url, :country, :image, :id

  def initialize(recipe, country)
    @title = recipe[:label]
    @url = recipe[:url]
    @image = recipe[:image]
    @country = country
    @id = nil
  end
end