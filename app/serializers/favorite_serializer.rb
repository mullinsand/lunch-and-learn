class FavoriteSerializer
  include JSONAPI::Serializer
  
  attributes :recipe_link, :recipe_title, :created_at, :country

end