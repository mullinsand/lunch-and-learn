class ApplicationController < ActionController::API
  private

  def country_exists?
    RestCountriesFacade.all_countries_names.include?(params[:country].downcase)
  end

  def country_not_found
    render json: { error: 'Country not found' }, status: 404
  end
end
