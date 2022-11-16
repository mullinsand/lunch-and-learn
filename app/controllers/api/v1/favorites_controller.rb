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

  def destroy
    user = User.find_by(api_key: api_key_param[:api_key])
    raise ActiveRecord::RecordNotFound.new, 'Incorrect api key used' if user.nil?

    favorite = user.favorites.find_by(id: favorite_id_param[:favorite_id])
    raise ActiveRecord::RecordNotFound.new, 'Incorrect favorite id used' if favorite.nil?
    
    favorite.destroy
    render json: { success: 'Favorite successfully deleted' }
  end

  private

  def api_key_param
    params.permit(:api_key)
  end

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end

  def favorite_id_param
    params.permit(:favorite_id)
  end
end