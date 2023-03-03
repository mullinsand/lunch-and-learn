require 'rails_helper'

RSpec.describe 'GET /api/v1/users' do
  describe 'get a users info' do
    context 'request body contains a name and pswd' do
      it 'a user is looked up email and password with response containing users name, email, and api_key' do
        @request_body = {  name: 'Arthur',
          email: 'argle@blargle.aaa',
          password: '123456',
          password_confirmation: '123456' }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
        post '/api/v1/users', headers: @request_headers, params: @request_body.to_json

        @request_body = { email: 'argle@blargle.aaa', password: '123456'}

        get '/api/v1/users', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(201)
        @user_response = json
        expect(@user_response[:data]).to be_a(Hash)
        expect(@user_response[:data][:id]).to be_a(String)
        expect(@user_response[:data][:type]).to eq('user')
        expect(@user_response[:data][:attributes]).to be_a(Hash)
        expect(@user_response[:data][:attributes][:name]).to eq(@request_body[:name])
        expect(@user_response[:data][:attributes][:email]).to eq(@request_body[:email])
        expect(@user_response[:data][:attributes][:api_key]).to be_a(String)
      end
    end
  end
end

