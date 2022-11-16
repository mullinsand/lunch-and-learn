require 'rails_helper'

RSpec.describe 'GET /api/v1/favorites' do
  describe 'creating a new favorite' do
    context 'request body contains only a valid api_key' do
      before :each do
        @user = create(:user)
        @user2 = create(:user)
        @user_favorites = create_list(:favorite, 3, user: @user)
        @other_favorite = create(:favorite)
        @request_body = { "api_key": @user.api_key }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end
      it 'returns all favorites belonging to that user' do
        get '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json
        expect(response.status).to eq(200)
        favorites_response = json
        expect(favorites_response[:data].length).to eq(3)
      end

      it 'has within each element of the response, a favorite object with attributes plus created_at' do
        get '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json
        expect(response.status).to eq(200)
        favorites_response = json
        expect(favorites_response[:data].first[:id]).to eq(@user_favorites.first.id.to_s)
        expect(favorites_response[:data].first[:type]).to eq('favorite')
        expect(favorites_response[:data].first[:attributes][:recipe_title]).to eq(@user_favorites.first.recipe_title)
        expect(favorites_response[:data].first[:attributes][:recipe_link]).to eq(@user_favorites.first.recipe_link)
        expect(favorites_response[:data].first[:attributes][:country]).to eq(@user_favorites.first.country)
        expect(favorites_response[:data].first[:attributes][:created_at].to_datetime.to_s(:db)).to eq(@user_favorites.first.created_at.to_s(:db))
        expect(favorites_response[:data].first.keys.length).to eq(3)
        expect(favorites_response[:data].first[:attributes].keys.length).to eq(4)
      end
    end

    context 'request contains an api key that is invalid (no user with that key)' do
      it 'response contains an error message' do
        @user = create(:user)
        @request_body = { api_key: 123456456 }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
  
        get '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(404)
        @user_response = json
        expect(@user_response[:errors]).to eq('Incorrect api key used')
      end
    end

    context 'user has no favorites' do
      it 'data object is just an empty array' do
        @user = create(:user)
        @request_body = { api_key: @user.api_key }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
  
        get '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        favorites_response = json
        expect(favorites_response[:data]).to eq([])
      end
    end
  end
end