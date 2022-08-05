class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { 'message' => e.message, 'detail' => 'extra info about not found' }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { 'message' => e.message, 'detail' => 'something invalid' }, status: :bad_request
  end

  # rescue_from StandardError do |e|
  #   render json: { 'message' => e.message, 'detail' => 'failure' }, status: :bad_request
  # end
end
