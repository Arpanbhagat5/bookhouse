require 'rails_helper'

# spec/requests/authentication_request_spec.rb
RSpec.describe 'Authentications', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, username: 'userA', password: 'mypass') }
    it 'successfully authenticates the user' do
      post '/api/v1/login', params: { username: user.username, password: 'mypass' }
      expect(response).to have_http_status(:created)
      expect(json).to eq({
                           'id' => user.id,
                           'username' => 'userA',
                           'token' => AuthenticationTokenService.invoke(user.id)
                         })
    end
    it 'returns error when user does not exist' do
      post '/api/v1/login', params: { username: 'ac', password: 'mypass' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'No such user'
                         })
    end
    it 'returns error for incorrect password' do
      post '/api/v1/login', params: { username: user.username, password: 'incorrect' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({
                           'error' => 'Incorrect password'
                         })
    end
  end
end