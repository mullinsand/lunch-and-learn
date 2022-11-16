require 'rails_helper'

RSpec.describe 'POST /api/v1/favorites' do
  describe 'creating a new favorite' do
    context 'request body contains a valid api_key, country, and recipe link/title' do
      before :each do
        @user = create(:user)
        @request_body = {
          api_key: @user.api_key,
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/.....",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end
      it 'creates a new favorite recipe belonging to that user' do
        expect(User.last.favorites).to eq([])
        post '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json
        expect(response.status).to eq(201)

        expect(User.last.favorites.first.recipe_title).to eq(@request_body[:recipe_title])
      end

      it 'gives a success message response' do
        post '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        @user_response = json
        expect(@user_response[:success]).to eq('Favorite added successfully')
      end
    end

    context 'request contains an api key that is invalid (no user with that key)' do
      it 'response contains an error message' do
        @user = create(:user)
        @request_body = {
                           api_key: 123456456,
                           country: "thailand",
                           recipe_link: "https://www.tastingtable.com/.....",
                           recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
                        }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
  
        post '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(404)
        @user_response = json
        expect(@user_response[:errors]).to eq('Incorrect api key used')
      end
    end

    context 'request body contains a valid api_key, but missing one or more other attributes' do
      before :each do
        @user = create(:user)
        @request_body = {
          api_key: @user.api_key,
          recipe_link: "https://www.tastingtable.com/.....",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end

      it 'returns an error message detailing what was missing' do
        post '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(422)

        expect(json[:errors]).to eq("Validation failed: Country can't be blank")
      end
    end
  end
end