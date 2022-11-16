class Api::V1::UsersController < ApplicationController
  include ExceptionHandler
  include Response

  def create
    params[:api_key] = SecureRandom.uuid
    user = User.new(user_params)
    render json: UserSerializer.new(user), status: 201 if user.save!
  end

  private
  
  def user_params
    params[:email] = params[:email].downcase if params[:email]
    params.permit(:name, :email, :api_key, :password, :password_confirmation)
  end
end