require 'rails_helper'

RSpec.describe PlacesFacade do
  describe 'class methods' do
    describe '#capital_tourist_sights' do
      before :each do
        @country = 'germany'
        @distance = 20000
        VCR.use_cassette('germany_country_lookup') do
          VCR.use_cassette('germany_places_tourist') do
            @tourist_sights_list = PlacesFacade.capital_tourist_sights(@country, @distance)
          end
        end
      end
      context 'there are results for the search' do
        it 'returns an array tourist sight class objects' do
          expect(@tourist_sights_list).to be_an(Array)
          expect(@tourist_sights_list.first).to be_a(TouristSight)
        end
      end

      context 'there are no results for the search' do
        it 'returns an empty array' do
          expect(@tourist_sights_list).to be_an(Array)
          expect(@tourist_sights_list.first).to be_a(TouristSight)
        end
      end
    end

    describe '#random_country' do
      before :each do
        VCR.use_cassette('all_countries') do
          @random_country = RestCountriesFacade.random_country
        end
      end

      it 'returns a a single country name' do
        expect(@random_country).to be_a(String)
      end

      it 'name is one of the countries listed' do
        VCR.use_cassette('all_countries') do
          @all_countries_names = RestCountriesFacade.all_countries_names
        end
        expect(@all_countries_names).to include(@random_country)
      end
    end

    describe '#capital_lat_long' do
      before :each do
        @country = 'germany'
        VCR.use_cassette('germany_country_lookup') do
          @capital_info = RestCountriesFacade.capital_lat_long(@country)
        end
      end

      it 'returns a hash with the lat and long of the countrys capital as keys in the hash' do
        expect(@capital_info).to be_a(Hash)
        expect(@capital_info[:lat]).to eq(52.52)
        expect(@capital_info[:long]).to eq(13.4)
      end
    end
  end
end
