class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      return country_not_found unless country_exists?

      recipes = EdamamFacade.recipes_by(params[:country])
    else
      # TODO edge case country doesn't have recipes in edamam
      country = RestCountriesFacade.random_country
      recipes = EdamamFacade.recipes_by(country)
    end
    recipes == [] ? (render json: { data: [] }) : (render json: RecipeSerializer.new(recipes))
  end
end