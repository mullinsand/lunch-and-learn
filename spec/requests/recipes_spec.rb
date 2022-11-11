require 'rails_helper'

RSpec.describe 'GET /api/v1/recipes' do
  describe 'endpoint that receives a country and returns 10 recipes from that country' do
    context 'when a country param is passed in' do
      context 'there are 10 or more recipes' do
        before :each do
          @country = 'thailand'
          VCR.use_cassette('Recipe_search_Thailand') do
            get "/api/v1/recipes?country=#{@country}"
          end
          @recipe_response = json
        end
        it 'returns a hash response with data key' do
          expect(response).to be_successful
          expect(@recipe_response[:data]).to be_an(Array)
        end

        it 'each element in data is a recipe type' do
          expect(@recipe_response[:data].first[:type]).to eq('recipe')
        end

        it 'each element in data has only title, url, country, and image attributes' do
          recipe_attributes = @recipe_response[:data].first[:attributes]
          expect(recipe_attributes[:url]).to be_a(String)
          expect(recipe_attributes[:title]).to be_a(String)
          expect(recipe_attributes[:image]).to be_a(String)
          expect(recipe_attributes[:country]).to eq(@country)
          expect(recipe_attributes.keys.length).to eq(4)
        end
        it 'returns at most 10 recipes from that country' do
          expect(@recipe_response[:data].length).to eq(10)
        end
      end
      context 'there are fewer than 10 recipes' do
        it 'returns at the number of recipes found from that country' do
          @country = 'thailand'
          VCR.use_cassette('2_results_Recipe_search_Thailand') do
            get "/api/v1/recipes?country=#{@country}"
          end
          @recipe_response = json
          expect(@recipe_response[:data].length).to eq(2)
        end
      end

      context 'there are no results' do
        it 'returns a data key with an empty array as its value' do
          country = 'Uranus'
          VCR.use_cassette('No_Recipe_search_Uranus') do
            get "/api/v1/recipes?country=#{country}"
          end
          @recipes_list = json
          expect(@recipes_list[:data]).to eq([])
        end
      end
    end

    context 'when a country param is not passed in' do
      it 'picks a random country and returns recipes for that country' do
        allow(RestCountriesFacade).to receive(:random_country).and_return('thailand')
        VCR.use_cassette('Recipe_search_Thailand') do
          get "/api/v1/recipes"
        end
        @recipes_list = json
        expect(response).to be_successful
        expect(@recipes_list[:data]).to be_an(Array)
        expect(@recipes_list[:data].first[:country]).to eq(@country)
      end
    end
  end
end