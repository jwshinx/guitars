module Api
  module V1
    class StoresController < ApplicationController
      def create
        store = Store.create!(store_params)
        render json: StoreSerializer.new(store).as_json, status: :ok
      end

      def index
        stores = Store.includes(:units, :guitars).all

        render json: StoresSerializer.new(stores).as_json, status: :ok
      end

      def show
        store = Store.includes(:units, :guitars).find(params[:id])
        clear_cache = false
        owner_name, response_errors = Jsonplaceholder::Owner.random({}, clear_cache, store.id)
        render json: StoreSerializer.new(store, owner_name).as_json, status: :ok
      end

      def destroy
        store = Store.find(params[:id])
        store.destroy!
        render json: {}, status: :ok
      end

      def update
        store = Store.find(params[:id])
        store.update!(store_params)
        render json: StoreSerializer.new(store).as_json, status: :ok
      end

      private

      def store_params
        params.require(:store).permit(:name, :active, :guitar_ids => [])
      end
    end
  end
end
