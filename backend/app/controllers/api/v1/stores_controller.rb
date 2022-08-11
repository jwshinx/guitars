module Api
  module V1
    class StoresController < ApplicationController
      def create
        store = Store.create!(store_params)
        render json: StoreSerializer.new(store).as_json, status: :ok
      end

      def index
        stores = Store.all

        render json: StoresSerializer.new(stores).as_json, status: :ok
      end

      def show
        store = Store.find(params[:id])
        render json: StoreSerializer.new(store).as_json, status: :ok
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
        params.require(:store).permit(:name, :active)
      end
    end
  end
end
