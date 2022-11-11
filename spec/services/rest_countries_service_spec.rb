require 'rails_helper'

RSpec.describe RestCountriesService do
  describe 'all_countries' do
    before :each do
      VCR.use_cassette('all_countries') do
        @response = RestCountriesService.all_countries
      end
    end
    it 'returns an array of the names of all countries' do
      expect(@response).to be_an(Array)
    end

    it 'each element has a name key which has a common key' do
      expect(@response.first[:name]).to be_a(Hash)
      expect(@response.first[:name][:common]).to be_a(String)
    end
  end
end