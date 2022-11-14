module Request
  def key_api_key
    JSON.parse(params.keys.find { |key| key.include?('api_key')})
  end
end