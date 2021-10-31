# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordInvalid do |error|
    render json: {
      errors: error.record.errors
    }, status: :unprocessable_entity
  end

  rescue_from ::ActiveRecord::RecordNotFound do |error|
    render json: {
      errors: { record: ["Couldn't find #{error.model} with 'id'=#{error.id}"] }
    }, status: :not_found
  end

  def render_params_error(result)
    return if result.success?

    render json: { errors: result.errors(full: true).to_h },
           status: :unprocessable_entity
  end
end
