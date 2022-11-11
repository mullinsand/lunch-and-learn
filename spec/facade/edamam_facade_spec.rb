require 'rails_helper'

RSpec.describe EdamamFacade do
  describe 'recipes by country' do
    before :each do
      country = 'thailand'
      VCR.use_cassette('Recipe_search_Thailand') do
        @recipes_list = EdamamFacade.recipes_by(country)
      end
    end
    
    it 'returns a list of 10 recipe objects' do
      expect(@recipes_list).to be_an(Array)
      expect(@recipes_list.length).to eq(10)
      expect(@recipes_list.first).to be_a(Recipe)
    end

    context 'no search results' do
      it 'returns an empty array' do
        country = 'Uranus'
        VCR.use_cassette('No_Recipe_search_Uranus') do
          @recipes_list = EdamamFacade.recipes_by(country)
        end
        expect(@recipes_list).to eq([])
      end
    end
  end
end