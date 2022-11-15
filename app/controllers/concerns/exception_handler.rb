module ExceptionHandler

  extend ActiveSupport::Concern

  def invalid_user_creation(user)
    json_response({error: user.errors.full_messages.to_sentence}, :unprocessable_entity)
  end

  def invalid_api_key
    json_response({error: 'Incorrect api key used'}, :unprocessable_entity)
  end

  def country_not_found
    json_response({error: 'Country not found'}, :unprocessable_entity)
  end
end