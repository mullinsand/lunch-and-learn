require 'rails_helper'

RSpec.describe 'POST /api/v1/users' do
  describe 'creating a new user' do
    context 'request body contains a name, unique email, pswd, and confirm pswd' do
      it 'a new user is created with response containing users name, email and api_key' do
        @request_body = {  name: 'Arthur',
                          email: 'argle@blargle.aaa',
                          password: '123456',
                          password_confirmation: '123456' }
        @request_headers = { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        post '/api/v1/users', headers: @request_headers, params: @request_body.to_json


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

    context 'request contains an email that is not unique' do
      it 'response contains an error message' do
        @request_body = {  name: 'Arthur',
          email: 'argle@blargle.aaa',
          password: '123456',
          password_confirmation: '123456' }
  
        @request_headers = { 'Content-Type': 'application/json',
            'Accept': 'application/json' }
  
        post '/api/v1/users', headers: @request_headers, params: @request_body.to_json

        post '/api/v1/users', headers: @request_headers, params: @request_body.to_json

        expect(response.status).to eq(422)
        @user_response = json
        expect(@user_response[:error]).to eq('Email has already been taken')
      end
    end
  end
end