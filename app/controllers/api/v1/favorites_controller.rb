class Api::V1::FavoritesController < ApplicationController
  include ExceptionHandler
  include Response

  def create
    @user = User.find_by(api_key_param)
    if @user
      favorite = @user.favorites.new(favorite_params)
      if favorite.valid?
        favorite.save
        render json: { success: 'Favorite added successfully' }, status: 201
      end
      
    else
      invalid_api_key
    end
  end

  private

  def api_key_param
    params.permit(:api_key)
  end

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end
end