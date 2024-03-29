class Api::V1::UsersController < ApplicationController
  include ExceptionHandler
  include Response

  def create
    make_api_key

    user = User.new(user_params)
    render json: UserSerializer.new(user), status: 201 if user.save!
  end

  def show
    user = User.find_by!(email: user_params[:email])
    return render json: UserSerializer.new(user), status: 201 if user.authenticate(params[:password])

    render json: { errors: "Password incorrect" }, status: 401
  end

  private
  
  def user_params
    params[:email] = params[:email].downcase if params[:email]
    params.permit(:name, :email, :api_key, :password, :password_confirmation)
  end

  def make_api_key
    params[:api_key] = SecureRandom.uuid
  end
end