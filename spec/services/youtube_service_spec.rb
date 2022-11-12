require 'rails_helper'

RSpec.describe YoutubeService do
  describe 'class methods' do
    describe 'video_about country' do
      context 'search returns results' do
        before :each do
          @country = 'germany'
          VCR.use_cassette('germany_youtube_video_search') do
            @response = YoutubeService.video_about(@country)
          end
        end
        it 'returns a hash with videos in it' do
          expect(@response).to be_a(Hash)
          expect(@response[:items]).to be_an(Array)
          expect(@response[:items].first).to be_a(Hash)
        end
        it 'each video element has a videoId and title' do
          expect(@response[:items].first[:id][:videoId]).to be_a(String)
          expect(@response[:items].first[:snippet][:title]).to be_a(String)
        end
      end

      context 'search returns no results' do
        it 'returns a hash with empty items array' do
          @country = 'uranus'
          VCR.use_cassette('no_results_youtube_video_search') do
            @response = YoutubeService.video_about(@country)
          end
          expect(@response).to be_a(Hash)
          expect(@response[:items]).to eq([])
        end
      end
    end
  end
end