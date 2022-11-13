require 'rails_helper'

RSpec.describe YoutubeFacade do
  describe 'class methods' do
    describe 'video about country' do
      before :each do
        @country = 'thailand'
        VCR.use_cassette('Thailand_youtube_video') do
          @video = YoutubeFacade.video_about(@country)
        end
      end
      
      it 'returns a country_video class object' do
        expect(@video).to be_a(CountryVideo)
        expect(@video.title).to be_a(String)
        expect(@video.video_id).to be_a(String)
      end

      context 'no search results' do
        it 'returns an empty array' do
          country = 'Uranus'
          VCR.use_cassette('Uranus_youtube_video') do
            @video = YoutubeFacade.video_about(country)
          end
          expect(@video).to eq([])
        end
      end
    end
  end
end