require 'rails_helper'

describe 'Guitar', type: :request do
  describe 'DELETE /api/v1/guitars/:id' do
    context 'given valid id' do
      it 'should destroy guitar' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        delete "/api/v1/guitars/#{guitar.id}"
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq({})
      end
    end

    context 'given invalid id' do
      it 'should not destroy guitar' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        randon_number = 333
        delete "/api/v1/guitars/#{guitar.id + randon_number}"
        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Guitar/)
      end
    end
  end

  describe 'PUT /api/v1/guitars/:id' do
    context 'given invalid id' do
      it 'should not update guitar' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        random_number = 333
        put "/api/v1/guitars/#{guitar.id + random_number}"
        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Guitar/)
      end
    end

    context 'given valid id' do
      it 'should update guitar' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        put "/api/v1/guitars/#{guitar.id}", params: {
          guitar: {
            name: 'fender 999'
          }
        }
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq(
          {'id' => 1, 'name' => 'fender 999', 'price' => 500},
        )
      end
    end
  end

  describe 'GET /api/v1/guitars/:id' do
    context 'given invalid id' do
      it 'should return an' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        random_number = 333
        get "/api/v1/guitars/#{guitar.id + random_number}"
        expect(response).to have_http_status(:bad_request)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Guitar/)
      end
    end

    context 'given valid id' do
      it 'should return guitars with id' do
        guitar = create(:guitar, name: 'fender 123', price: 500)

        get "/api/v1/guitars/#{guitar.id}"
        expect(response).to have_http_status(:ok)

        data = JSON.parse(response.body)

        expect(data).to eq(
          {'id' => 1, 'name' => 'fender 123', 'price' => 500},
        )
      end
    end
  end

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
