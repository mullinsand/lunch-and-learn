class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country] || RestCountriesFacade.random_country
    return country_not_found unless country_exists?(country)

    recipes = EdamamFacade.recipes_by(country)
    render json: RecipeSerializer.new(recipes)
  end
end