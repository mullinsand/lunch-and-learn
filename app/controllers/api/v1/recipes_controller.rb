class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      recipes = EdamamFacade.recipes_by(params[:country])
    else
      country = RestCountriesFacade.random_country
      recipes = EdamamFacade.recipes_by(country)
    end
    recipes == [] ? (render json: { data: [] }) : (render json: RecipeSerializer.new(recipes))
  end
end