module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |error|
      render json: { errors: error.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      render json: { errors: error.message }, status: :unprocessable_entity
    end
  end

  def country_not_found
    json_response({error: 'Country not found'}, :unprocessable_entity)
  end
end