class RecipeSerializer
  include JSONAPI::Serializer
  
  attributes :url, :title, :image, :country

  def self.no_results
    {
      data: []
    }
  end
end