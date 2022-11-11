require 'rails_helper'

RSpec.describe EdamamService do
  describe 'recipes by country' do
    before :each do
      country = 'thailand'
      VCR.use_cassette('Recipe_search_Thailand') do
        @response = EdamamService.recipes_by(country)
      end
    end
    it 'returns a hash' do
      expect(@response).to be_a(Hash)
    end
    it 'has a hits key with an array as value' do
      expect(@response[:hits]).to be_an(Array)
    end

    it 'each element in the array has a uri, label, and image/images key' do
      recipe = @response[:hits].first[:recipe]
      expect(recipe[:url]).to be_a(String)
      expect(recipe[:label]).to be_a(String)
      expect(recipe[:image]).to be_a(String)
    end

    it 'only three keys in the element' do
      recipe = @response[:hits].first[:recipe]
      expect(recipe.keys.length).to eq(3)
    end
  end
end