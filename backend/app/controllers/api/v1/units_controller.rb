module Api
  module V1
    class UnitsController < ApplicationController
      def create
        # byebug
        unit = Unit.create!(unit_params)
        render json: UnitSerializer.new(unit).as_json, status: :ok
      end

      def index
        units = Unit.all
        render json: UnitsSerializer.new(units).as_json, status: :ok
      end

      def show
        unit = Unit.find(params[:id])
        render json: UnitSerializer.new(unit).as_json, status: :ok
      end

      def destroy
        unit = Unit.find(params[:id])
        unit.destroy!
        render json: {}, status: :ok
      end

      def update
        unit = Unit.find(params[:id])
        unit.update!(unit_params)
        render json: UnitSerializer.new(unit).as_json, status: :ok
      end

      private

      def unit_params
        params.require(:unit).permit(:guitar_id, :store_id)
      end
    end
  end
end
