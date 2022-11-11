class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      recipes = EdamamFacade.recipes_by(params[:country])
      recipes == [] ? (render json: { data: [] }) : (render json: RecipeSerializer.new(recipes))
    else
      # country = RestCountriesService.all_countries.sample
      # EdamamFacade.recipe_by(country)
    end
  end
end