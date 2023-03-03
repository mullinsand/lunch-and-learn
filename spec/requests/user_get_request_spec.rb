require 'rails_helper'

RSpec.describe 'GET /api/v1/users' do
  describe 'get a users info' do
    context 'request body contains a name and pswd' do
      it 'a user is looked up email and password with response containing users name, email, and api_key' do
        @request_body = { email: 'argle@blargle.aaa', password: '123456'}
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        get '/api/v1/users', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(201)
        @user_response = json
        expect(@user_response[:data][:attributes][:api_key]).to be_a(String)

      end
    end
  end
end

