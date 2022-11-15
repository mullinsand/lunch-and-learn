require 'rails_helper'

RSpec.describe 'GET /api/v1/tourist_sights' do
  describe 'get all tourist sights from a 20000 meter radius of capital city' do
    context 'there are results for tourist sights' do
      before :each do
        @country = 'germany'
        VCR.use_cassette('germany_country_lookup') do
          VCR.use_cassette('germany_places_tourist') do
            get "/api/v1/tourist_sights?country=#{@country}"
          end
        end
        @tourist_sights_response = json
      end
      it 'returns a hash with data key' do
        expect(response).to be_successful
        expect(@tourist_sights_response[:data]).to be_an(Array)
        expect(@tourist_sights_response).to be_an(Hash)
      end

      it 'each element in data is a tourist_sight type' do
        expect(@tourist_sights_response[:data].first[:type]).to eq('tourist_sight')
      end

      it 'returns a list of tourist sight objects with attributes name/address/place_id' do
        tourist_sight_attributes = @tourist_sights_response[:data].first[:attributes]
        expect(tourist_sight_attributes[:name]).to be_a(String)
        expect(tourist_sight_attributes[:place_id]).to be_a(String)
        expect(tourist_sight_attributes[:address]).to be_a(String)
        expect(tourist_sight_attributes.keys.length).to eq(3)
      end
    end

    context 'there are no results for tourist sights' do
      it 'returns a hash with data key value of an empty array' do
          @country = 'Ecuador'
          allow(PlacesFacade).to receive(:capital_tourist_sights).and_return([])
          get "/api/v1/tourist_sights?country=#{@country}"
          @tourist_sights_response = json
          expect(@tourist_sights_response[:data]).to eq([])
      end
    end

    context 'no country name is passed in' do
      it "returns a random country's tourist sights" do
        @country = 'germany'
        allow(RestCountriesFacade).to receive(:random_country).and_return(@country)
        VCR.use_cassette('germany_country_lookup') do
          VCR.use_cassette('germany_places_tourist') do
            get "/api/v1/tourist_sights"
          end
        end
        @tourist_sights_response = json
        tourist_sight_address = @tourist_sights_response[:data].first[:attributes][:address]
        expect(tourist_sight_address).to include(@country.capitalize)
      end
    end

    context 'country name does not exist/misspelled' do
      it 'returns an error status code' do
        @country = 'asdfjkl'
        VCR.use_cassette('all_countries') do
          get "/api/v1/tourist_sights?country=#{@country}"
        end

        @error_response = json

        @error_response[:error] = 'Country not found'
      end
    end
  end
end