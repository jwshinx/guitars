require 'rails_helper'

describe 'Guitar', type: :request do
  describe 'GET /api/v1/guitars' do
    it 'should return all guitars' do
      create(:guitar, name: 'fender 123')

      get '/api/v1/guitars'
      expect(Guitar.all.length).to eq(1)
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data.first['name']).to eq('fender 123')
    end
  end
end
