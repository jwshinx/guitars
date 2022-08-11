module Api
  module V1
    class UnitsController < ApplicationController
      def create
        # byebug
        unit = Unit.create!(unit_params)
        render json: {}, status: :ok
        # store = Store.create!(store_params)
        # render json: StoreSerializer.new(store).as_json, status: :ok
      end

      def index
        units = Unit.all
        render json: UnitsSerializer.new(units).as_json, status: :ok
        
        # render json: StoresSerializer.new(stores).as_json, status: :ok
      end

      def show
        # store = Store.find(params[:id])
        # render json: StoreSerializer.new(store).as_json, status: :ok
      end

      def destroy
        # store = Store.find(params[:id])
        # store.destroy!
        # render json: {}, status: :ok
      end

      def update
        # store = Store.find(params[:id])
        # store.update!(store_params)
        # render json: StoreSerializer.new(store).as_json, status: :ok
      end

      private

      def unit_params
        params.require(:unit).permit(:guitar_id, :store_id)
      end
    end
  end
end
