require 'rails_helper'

RSpec.describe 'GET /api/v1/learning_resources' do
  describe 'endpoint that receives a country and learning resource for that country' do
    context 'when a country param is passed in' do
      context 'there results for both image and video' do
        before :each do
          @country = 'germany'
          VCR.use_cassette('germany_unsplash_image_search') do
            VCR.use_cassette('germany_youtube_video_search') do
              get "/api/v1/learning_resources?country=#{@country}"
            end
          end
          @learning_recource = json
        end

        it 'returns a hash response with data key' do
          expect(response).to be_successful
          expect(@learning_recource[:data]).to be_an(Hash)
        end

        it 'inside data is a single object of type learning resource' do
          expect(@learning_recource[:data][:type]).to eq('learning_resource')
        end

        it 'learning resource attributes are only country, video, and images' do
          expect(@learning_recource[:data][:attributes].keys.length).to eq(3)

          expect(@learning_recource[:data][:attributes][:country]).to eq(@country)
          expect(@learning_recource[:data][:attributes][:video]).to be_a(Hash)
          expect(@learning_recource[:data][:attributes][:images]).to be_an(Array)
        end

        it 'video hash has only two keys' do
          expect(@learning_recource[:data][:attributes][:video].keys.length).to eq(2)
          expect(@learning_recource[:data][:attributes][:video][:title]).to be_a(String)
          expect(@learning_recource[:data][:attributes][:video][:video_id]).to be_a(String)
        end

        it 'image hash is an array with 10 hashes each with only two keys' do
          expect(@learning_recource[:data][:attributes][:images].length).to eq(10)
          expect(@learning_recource[:data][:attributes][:images].first).to be_a(Hash)
          expect(@learning_recource[:data][:attributes][:images].first.keys.length).to eq(2)
          expect(@learning_recource[:data][:attributes][:images].first[:alt_tag]).to be_a(String)
          expect(@learning_recource[:data][:attributes][:images].first[:url]).to be_a(String)
        end
      end
    end
  end
end