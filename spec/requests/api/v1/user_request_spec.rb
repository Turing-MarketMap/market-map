require 'rails_helper'

RSpec.describe 'Users API', type: :request do 

  describe 'create a user' do 
    it 'successfully creates' do
      params = { first_name: 'John', last_name: 'Doe', email: 'jdoe@gmail.com' }
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: params)

      new_user = User.last 

      expect(response.status).to eq(200)
      expect(new_user.first_name).to eq(params[:first_name])
      expect(new_user.last_name).to eq(params[:last_name])
      expect(new_user.email).to eq(params[:email])
    end

    it 'finds the user if it already exists' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'jdoe@gmail.com')

      params = { first_name: 'John', last_name: 'Doe', email: 'jdoe@gmail.com' }
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: params)

      expect(User.count).to eq(1) 
      expect(parse_json[:data][:attributes][:first_name]).to eq(user.first_name)
      expect(parse_json[:data][:attributes][:last_name]).to eq(user.last_name)
      expect(parse_json[:data][:attributes][:email]).to eq(user.email)
    end

    it 'has no params to create user' do 
      params = {}
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: params)

      new_user = User.last 

      expect(response.status).to eq(422)
      expect(parse_json[:errors]).to eq("param is missing or the value is empty: user")
    end

    it 'has some params to create user' do 
      params = { first_name: 'John', last_name: 'Doe' }
      headers = { 'CONTENT_TYPE' => 'application/json'}

      post api_v1_users_path, headers: headers, params: JSON.generate(user: params)

      expect(response.status).to eq(422)
      expect(parse_json[:email]).to eq(["can't be blank", "is invalid"])
    end    
  end
  
  describe 'destroys a user' do 
    it 'successfully destroys a user' do 
      user = create(:user)

      expect(User.count).to eq(1)

      delete api_v1_user_path(user)

      expect(response.status).to eq(204)
      expect(User.count).to eq(0)
    end
  end
end