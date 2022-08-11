require 'rails_helper'

describe '/api/v1/stores', type: :routing do
  describe 'GET /api/v1/stores/:id' do
    it 'should route to stores#show' do
      store = create(:store)
      expect(:get => "/api/v1/stores/#{store.id}").to route_to(
        {
          controller: 'api/v1/stores',
          action: 'show',
          id: store.id.to_s
        }
      )
    end
  end

  describe 'DELETE /api/v1/stores/:id' do
    it 'should route to stores#update' do
      store = create(:store)
      expect(:delete => "/api/v1/stores/#{store.id}").to route_to(
        {
          controller: 'api/v1/stores',
          action: 'destroy',
          id: store.id.to_s
        }
      )
    end
  end

  describe 'PUT /api/v1/stores/:id' do
    it 'should route to stores#update' do
      store = create(:store)
      expect(:put => "/api/v1/stores/#{store.id}").to route_to(
        {
          controller: 'api/v1/stores',
          action: 'update',
          id: store.id.to_s
        }
      )
    end
  end

  describe 'GET /api/v1/stores' do
    it 'should route to stores#index' do
      expect(:get => 'api/v1/stores').to route_to(
        {
          controller: 'api/v1/stores',
          action: 'index'
        }
      )
    end
  end

  describe 'POST /api/v1/stores' do
    it 'should route to stores#create' do
      expect(:post => '/api/v1/stores').to route_to(
        {
          controller: 'api/v1/stores',
          action: 'create'
        }
      )
    end
  end
end
