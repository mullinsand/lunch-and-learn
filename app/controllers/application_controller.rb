class ApplicationController < ActionController::API
  private

  def country_exists?(country)
    RestCountriesFacade.all_countries_names.include?(country.downcase)
  end

  def country_not_found
    render json: { error: 'Country not found' }, status: 404
  end
end
