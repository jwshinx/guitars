module Api
  module V1
    class GuitarsController < ApplicationController
      def create
        guitar = Guitar.create!(guitar_params)
        render json: GuitarSerializer.new(guitar).as_json, status: :ok
      end

      def index
        guitars = Guitar.all
        render json: GuitarsSerializer.new(guitars).as_json, status: :ok
      end

      private

      def guitar_params
        params.require(:guitar).permit(:name, :price)
      end
    end
  end
end
