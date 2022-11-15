require 'rails_helper'

RSpec.describe 'DELETE /api/v1/favorites' do
  describe 'deletes a favorite' do
    before :each do
      @user = create(:user)
      @user2 = create(:user)
      @favorites = create_list(:favorite, 3, user: @user)
      @favorites2 = create_list(:favorite, 3, user: @user2)

      @request_body = { "api_key": @user.api_key, "favorite_id": @favorites[0].id }
      @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    end
    context 'request body contains a valid api_key and valid favorite_id' do

      it 'creates a new favorite recipe belonging to that user' do
        expect(User.find(@user.id).favorites).to include(@favorites[0])
        delete '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json
        expect(response.status).to eq(200)
        expect(User.find(@user.id).favorites).to_not include(@favorites[0])
      end

      it 'gives a success message response' do
        delete '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        @user_response = json
        expect(@user_response[:success]).to eq('Favorite successfully deleted')
      end
    end

    context 'request contains an api key that is invalid (no user with that key)' do
      it 'response contains an error message' do
        @request_body = { "api_key": 123456, "favorite_id": @favorites[0].id }

        delete '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(404)
        expect(User.find(@user.id).favorites).to include(@favorites[0])
        @user_response = json
        expect(@user_response[:errors]).to eq('Incorrect api key used')
      end
    end

    context 'request contains a favorite id that does not exist or belongs to another user' do
      it 'response contains an error message' do
        @request_body = { "api_key": @user.api_key, "favorite_id": @favorites2[0].id }
  
        delete '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(404)
        expect(User.find(@user.id).favorites).to include(@favorites[0])
        @user_response = json
        expect(@user_response[:errors]).to eq('Incorrect favorite id used')
      end

      it 'response contains an error message' do
        @request_body = { "api_key": @user.api_key, "favorite_id": 123456789 }
  
        delete '/api/v1/favorites', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(404)
        expect(User.find(@user.id).favorites).to include(@favorites[0])
        @user_response = json
        expect(@user_response[:errors]).to eq('Incorrect favorite id used')
      end
    end
  end
end