require 'rails_helper'

describe 'Store', type: :request do
  describe 'POST /api/v1/stores' do
    context 'given valid params' do
      it 'should create a store' do
        expect {
          post '/api/v1/stores', params: {
            store: { name: 'the music shop', active: true}
          }
        }.to change { Store.count }.from(0).to(1)

        data = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(data['id']).to eq(1)
        expect(data['name']).to eq('the music shop')
        expect(data['active']).to eq(true)
      end
    end

    context 'given invalid params' do
      it 'should not create a store' do
        post '/api/v1/stores', params: {
          store: {
            name: '',
            active: true
          }
        }

        expect(response).to have_http_status(:bad_request)
        expect(Store.count).to eq(0)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'DELETE /api/v1/stores/:id' do
    context 'given valid id' do
      it 'should destroy store' do
        store = create(:store, name: 'the music shop')

        delete "/api/v1/stores/#{store.id}"
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq({})
      end
    end

    context 'given invalid id' do
      it 'should not destroy store' do
        store = create(:store, name: 'the music shop', active: true)

        random_number = 333
        delete "/api/v1/stores/#{store.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Store/)
      end
    end
  end

  describe 'PUT /api/v1/stores/:id' do
    context 'given invalid id' do
      it 'should not update store' do
        store = create(:store, name: 'the music shop', active: true)

        random_number = 333
        put "/api/v1/stores/#{store.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Store/)
      end
    end

    context 'given valid id' do
      it 'should update store' do
        store = create(:store, name: 'the music shop', active: true)

        put "/api/v1/stores/#{store.id}", params: {
          store: {
            name: 'the music shop sf'
          }
        }
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq(
          {'id' => 1, 'name' => 'the music shop sf', 'active' => true, 'guitars' => []},
        )
      end
    end
  end

  describe 'GET /api/v1/stores/:id' do
    context 'given invalid id' do
      it 'should return an' do
        store = create(:store, name: 'the music shop', active: true)

        random_number = 333
        get "/api/v1/stores/#{store.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Store/)
      end
    end

    context 'given valid id' do
      it 'should return stores with id' do
        store = create(:store, name: 'the music shop', active: true)

        get "/api/v1/stores/#{store.id}"
        expect(response).to have_http_status(:ok)

        data = JSON.parse(response.body)

        expect(data).to eq(
          {'id' => 1, 'name' => 'the music shop', 'active' => true, 'guitars' => []},
        )
      end
    end
  end

  describe 'GET /api/v1/stores' do
    it 'should return all stores' do
      create(:store, name: 'the music shop')

      get '/api/v1/stores'
      expect(Store.all.length).to eq(1)
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data.first['name']).to eq('the music shop')
    end
  end
end
