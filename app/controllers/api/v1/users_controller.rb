class Api::V1::UsersController < ApplicationController
  include ExceptionHandler
  include Response

  def create
    user_params[:email] = user_params[:email.downcase] if user_params[:email]
    params[:api_key] = SecureRandom.uuid
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render json: UserSerializer.new(@user), status: 201
    else
      invalid_user_creation(@user)
    end
  end

  def user_params
    params.permit(:name, :email, :api_key, :password, :password_confirmation)
  end
end