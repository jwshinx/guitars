require 'rails_helper'

describe '/api/v1/guitars', type: :routing do
  describe 'GET /api/v1/guitars' do
    it 'should route to guitars#index' do
      expect(:get => '/api/v1/guitars').to route_to(
        {
          controller: 'api/v1/guitars',
          action: 'index'
        }
      )
    end
  end

  describe 'POST /api/v1/guitars' do
    it 'should route to guitars#create' do
      expect(:post => '/api/v1/guitars').to route_to(
        {
          controller: 'api/v1/guitars',
          action: 'create'
        }
      )
    end
  end
end
