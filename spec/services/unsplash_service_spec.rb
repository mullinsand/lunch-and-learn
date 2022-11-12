require 'rails_helper'

RSpec.describe UnsplashService do
  describe 'class methods' do
    describe 'images_of country' do
      context 'search returns results' do
        before :each do
          @country = 'germany'
          VCR.use_cassette('germany_unsplash_image_search') do
            @response = UnsplashService.images_of(@country)
          end
        end
        it 'returns a hash with videos in it' do
          expect(@response).to be_a(Hash)
          expect(@response[:results]).to be_an(Array)
          expect(@response[:results].first).to be_a(Hash)
        end
        it 'each image element has a videoId and title' do
          expect(@response[:results].first[:alt_description]).to be_a(String)
          expect(@response[:results].first[:urls][:regular]).to be_a(String)
        end
      end

      context 'search returns no results' do
        it 'returns a hash with empty items array' do
          @country = 'hjkladfhjkadfjklgadklfjgkohuhadsfgo;uihaweriouh'
          VCR.use_cassette('no_results_unsplash_image_search') do
            @response = UnsplashService.images_of(@country)
          end
          expect(@response).to be_a(Hash)
          expect(@response[:results]).to eq([])
        end
      end
    end
  end
end