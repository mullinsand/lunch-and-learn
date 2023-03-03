class EdamamFacade
  def self.recipes_by(country)
    Rails.cache.fetch("my_cache_key/recipes/#{country}", expires_in: 24.hours) do
      recipes_json = EdamamService.recipes_by(country)[:hits]
      recipes_json.take(10).map do |recipe|
        Recipe.new(recipe[:recipe], country)
      end
    end
  end
end