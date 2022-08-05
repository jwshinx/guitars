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

      def show
        guitar = Guitar.find(params[:id])
        render json: GuitarSerializer.new(guitar).as_json, status: :ok
      end

      def destroy
        guitar = Guitar.find(params[:id])
        guitar.destroy!
        render json: {}, status: :ok
      end

      def update
        guitar = Guitar.find(params[:id])
        guitar.update!(guitar_params)
        render json: GuitarSerializer.new(guitar).as_json, status: :ok
      end

      private

      def guitar_params
        params.require(:guitar).permit(:name, :price)
      end
    end
  end
end
