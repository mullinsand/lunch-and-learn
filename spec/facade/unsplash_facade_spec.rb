require 'rails_helper'

RSpec.describe UnsplashFacade do
  describe 'class methods' do
    describe 'video about country' do
      before :each do
        @country = 'germany'
        VCR.use_cassette('germany_unsplash_image_search') do
          @pictures = UnsplashFacade.images_of(@country)
        end
      end
      
      it 'returns a array of 10 country image class objects' do
        expect(@picture).to be_an(Array)
        expect(@picture.first).to be_a(CountryImage)
        expect(@picture.alt_description).to be_a(String)
        expect(@picture.url).to be_a(String)
      end

      context 'no search results' do
        it 'returns an empty array' do
          country = 'hjkladfhjkadfjklgadklfjgkohuhadsfgo;uihaweriouh'
          VCR.use_cassette('no_results_unsplash_image_search') do
            @pictures = UnsplashFacade.images_of(country)
          end
          expect(@pictures).to eq([])
        end
      end
    end
  end
end