class RecipeSerializer
  include JSONAPI::Serializer
  
  attributes :url, :title, :image, :country

end