require 'rails_helper'

describe 'Guitar', type: :request do
  describe 'POST /api/v1/guitars' do
    context 'given invalid params' do
      it 'should not create a guitar' do
        post '/api/v1/guitars', params: {
          guitar: {
            name: '',
            price: 1200
          }
        }

        expect(Guitar.count).to eq(0)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Validation failed: Name can't be blank/)
      end
    end

    context 'given invalid params' do
      it 'should create a guitar' do
        expect {
          post '/api/v1/guitars', params: {
            guitar: {
              name: 'gibson 444',
              price: 1200
            }
          }
        }.to change { Guitar.count }.from(0).to(1)

        data = JSON.parse(response.body)
        expect(data['id']).to eq(1)
        expect(data['name']).to eq('gibson 444')
        expect(data['price']).to eq(1200)
      end
    end
  end

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
