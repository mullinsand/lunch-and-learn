module ExceptionHandler

  extend ActiveSupport::Concern

  def invalid_user_creation(user)
    json_response({error: user.errors.full_messages.to_sentence}, :unprocessable_entity)
  end
end