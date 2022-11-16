class Api::V1::LearningResourcesController < ApplicationController
  def show
    country = params[:country] || RestCountriesFacade.random_country
    return country_not_found unless country_exists?(country)
    
    learning_resource = LearningResourceFacade.generate_for(country)
    render json: LearningResourceSerializer.new(learning_resource)
  end
end