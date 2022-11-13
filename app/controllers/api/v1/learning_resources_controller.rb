class Api::V1::LearningResourcesController < ApplicationController
  def show
    if params[:country]
      learning_resource = LearningResourceFacade.generate_for(params[:country])
      render json: LearningResourceSerializer.new(learning_resource)
    end
  end
end