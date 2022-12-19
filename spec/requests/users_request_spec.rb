require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    it 'authenticates the user' do
      post '/api/v1/register', params: { user: { username: 'userA', password: 'mypass' } }
      expect(response).to have_http_status(:created)
      expect(json).to eq({
                           # Try to authenticate the latest user
                           'id' => User.last.id,
                           'username' => 'userA',
                           'token' => AuthenticationTokenService.invoke(User.last.id)
                         })
    end
  end
end
