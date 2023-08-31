class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error
  
  def not_found_response(error)
    error_object = Error.new(error.message, 404)
    render json: ErrorSerializer.serialize_json(error_object), status: error_object.status
  end

  def validation_error(error)
    error_object = Error.new(error.message, 400)
    render json: ErrorSerializer.serialize_json(error_object), status: error_object.status
  end
end
