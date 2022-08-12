module Api
  module V1
    class GuitarsController < ApplicationController
      include Loggable

      def create
        guitar = Guitar.create!(guitar_params)
        render json: GuitarSerializer.new(guitar).as_json, status: :ok
      end

      def index
        puts log_params(params) unless Rails.env == 'test'
        guitars = Guitar.includes(:units, :stores).all
        render json: GuitarsSerializer.new(guitars).as_json, status: :ok
      end

      def show
        guitar = Guitar.includes(:units, :stores).find(params[:id])
        puts guitar.autographed unless Rails.env == 'test'
        render json: GuitarSerializer.new(guitar).as_json, status: :ok
      end

      def destroy
        guitar = Guitar.includes(:units, :stores).find(params[:id])
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
        params.require(:guitar).permit(:name, :price, :store_ids => [])
      end
    end
  end
end
