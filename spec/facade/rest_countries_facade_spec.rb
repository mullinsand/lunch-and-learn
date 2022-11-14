require 'rails_helper'

RSpec.describe RestCountriesFacade do
  describe 'class methods' do
    describe '#all country' do
      before :each do
        VCR.use_cassette('all_countries') do
          @all_countries = RestCountriesFacade.all_countries
        end
      end

      it 'returns a list of country names' do
        expect(@all_countries).to be_an(Array)
        expect(@all_countries.first).to be_a(Hash)
      end

      context 'no search results' do
        it 'returns an empty array' do

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
          @all_countries = RestCountriesFacade.all_countries
        end
        @all_names = @all_countries.map { |country| country[:name][:common] }
        expect(@all_names).to include(@random_country)
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
