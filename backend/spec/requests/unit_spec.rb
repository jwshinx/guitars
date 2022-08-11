require 'rails_helper'

describe 'Unit', type: :request do
  describe 'POST /api/v1/units' do
    before do
      @guitar = create(:guitar, name: 'fender 123', price: 500)
      @store = create(:store, name: 'music store usa', active: true)
    end

    context 'given valid params' do
      it 'should create a unit' do
        expect {
          post '/api/v1/units', params: {
            unit: { guitar_id: @guitar.id, store_id: @store.id, quantity: 5}
          }
        }.to change { Unit.count }.from(0).to(1)

        data = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(data).to eql(
          {
            "id" => 1,
            "quantity" => 5,
            "guitar" => {"name" => "fender 123", "price" => 500},
            "store" => {"name" => "music store usa", "active" => true}
          }
        )
      end
    end

    context 'given invalid params' do
      it 'should not create a unit' do
        post '/api/v1/units', params: {
          unit: { guitar_id: @guitar.id, store_id: @store.id, quantity: -1}
        }

        expect(response).to have_http_status(:bad_request)
        expect(Unit.count).to eq(0)
        data = JSON.parse(response.body)
        expect(data['message']).to match(
          /Validation failed: Quantity must be greater than or equal to 0/
        )
      end
    end
  end

  describe 'DELETE /api/v1/units/:id' do
    before do
      @guitar = create(:guitar, name: 'fender 123', price: 500)
      @store = create(:store, name: 'music store usa', active: true)
      @unit = create(:unit, guitar: @guitar, store: @store, quantity: 5)
    end

    context 'given valid id' do
      it 'should destroy unit' do
        delete "/api/v1/units/#{@unit.id}"
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq({})
      end
    end

    context 'given invalid id' do
      it 'should not destroy unit' do
        random_number = 333
        delete "/api/v1/units/#{@unit.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Unit/)
      end
    end
  end

  describe 'PUT /api/v1/units/:id' do
    before do
      @guitar = create(:guitar, name: 'fender 123', price: 500)
      @store = create(:store, name: 'music store usa', active: true)
    end

    context 'given invalid id' do
      it 'should not update unit' do
        unit = create(:unit, guitar: @guitar, store: @store, quantity: 5)

        random_number = 333
        put "/api/v1/units/#{unit.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Unit/)
      end
    end

    context 'given valid id' do
      it 'should update unit' do
        unit = create(:unit, guitar: @guitar, store: @store, quantity: 5)

        put "/api/v1/units/#{unit.id}", params: {
          unit: {
            quantity: 10
          }
        }
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq(
          {
            "guitar" => {"name" => "fender 123", "price" => 500},
            "id" => 1,
            "quantity" => 10,
            "store" => {"active" => true, "name" => "music store usa"}
          }
        )
      end
    end
  end

  describe 'GET /api/v1/units/:id' do
    before do
      @guitar = create(:guitar, name: 'fender 123')
      @store = create(:store, name: 'music store usa')
    end
  
    context 'given invalid id' do
      it 'should return an error' do
        unit = create(:unit, store: @store, guitar: @guitar, quantity: 5)

        random_number = 333
        get "/api/v1/units/#{unit.id + random_number}"
        expect(response).to have_http_status(:not_found)
        data = JSON.parse(response.body)
        expect(data['message']).to match(/Couldn't find Unit/)
      end
    end

    context 'given valid id' do
      it 'should return units with id' do
        unit = create(:unit, store: @store, guitar: @guitar, quantity: 5)

        get "/api/v1/units/#{unit.id}"
        expect(response).to have_http_status(:ok)
        data = JSON.parse(response.body)
        expect(data).to eq(
          {
            "guitar" => {"name" => "fender 123", "price" => 509},
            "id" => 1,
            "quantity" => 5,
            "store" => {"active" => true, "name" => "music store usa"}
          }
        )
      end
    end
  end

  describe 'GET /api/v1/units' do
    before do
      @guitar = create(:guitar, name: 'fender 123')
      @store = create(:store, name: 'music store usa')
    end

    it 'should return all units' do
      create(:unit, store: @store, guitar: @guitar, quantity: 5)

      get '/api/v1/units'
      expect(Unit.all.length).to eq(1)
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      # puts "xxx> data: #{data.inspect}"
      expect(data.first['guitar_name']).to eq('fender 123')
      expect(data.first['store_name']).to eq('music store usa')
    end
  end  
end
