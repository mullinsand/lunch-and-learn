class EdamamFacade
  def self.recipes_by(country)
    recipe_json = EdamamService.recipes_by(country)[:hits]
    recipe_json[0..9].map do |recipe|
      Recipe.new(recipe[:recipe], country)
    end
  end
end