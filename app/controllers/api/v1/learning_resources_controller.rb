class Api::V1::LearningResourcesController < ApplicationController
  def show
    if params[:country]
      return country_not_found unless country_exists?
      
      learning_resource = LearningResourceFacade.generate_for(params[:country])
      render json: LearningResourceSerializer.new(learning_resource)
    end
  end
end