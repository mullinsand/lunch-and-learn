require 'rails_helper'

RSpec.describe RestCountriesService do
  describe 'all_countries' do
    it 'returns an array of the names of all countries' do
      response = RestCountriesService.all_countries
      expect(response).to be_an(Array)
      expect(response).to be_an(Array)
      expect(response).to be_an(Array)
    end

    it 'does' do

    end
  end
end