require 'rails_helper'

describe 'Links index request', type: :request do
  context 'authenticated user' do
    it 'returns all links associated with logged in user' do
      authenticated_user = FactoryGirl.create(:user)
      user_link = FactoryGirl.create(:link, user: authenticated_user)
      allow_any_instance_of(
        ApplicationController
      ).to receive(:current_user).and_return(authenticated_user)

      get '/api/v1/links.json'

      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')
      expect(parsed_response.first['title']).to eq(user_link.title)
      expect(parsed_response.first['url']).to eq(user_link.url)
    end
  end

  context 'no authenticated user' do
    it 'returns a 400' do
      get '/api/v1/links.json'

      expect(response).to have_http_status(400)
    end

    it 'provides a descriptive message in body' do
      get '/api/v1/links.json'

      expect(response.body).to eq('Authentication required')
    end
  end
end
