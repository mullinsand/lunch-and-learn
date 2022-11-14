require 'rails_helper'

RSpec.describe RestCountriesService do
  describe 'class_methods' do
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

    describe '#capital_lat_long' do
      describe 'returns the lat and long of the capital of a given country' do
        before :each do
          @country = 'germany'
          VCR.use_cassette('germany_country_lookup') do
            @response = RestCountriesService.country_info(@country)
          end
        end

        it 'returns a hash of country info' do
          expect(@response).to be_a(Array)
        end

        it 'contains the data for the capital lat/long' do
          expect(@response.first[:capitalInfo]).to be_a(Hash)
          expect(@response.first[:capitalInfo][:latlng]).to be_an(Array)
        end
      end
    end
  end
end