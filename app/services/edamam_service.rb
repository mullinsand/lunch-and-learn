class EdamamService
  
  def self.conn(search_type)
    Faraday.new("https://api.edamam.com/api/#{search_type}/v2") do |f|
      f.params[:app_id] = ENV['EDAMAM_ID']
      f.params[:app_key] = ENV['EDAMAM_KEY']
      f.params[:type] = 'public'
    end
  end
  
  def self.recipes_by(country)
    response = conn('recipes').get do |f|
      f.params[:q] = country
      f.options.params_encoder = Faraday::FlatParamsEncoder
      f.params[:field] = ['label','url','image']
    end
    parse(response.body)
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end