# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from RailsParam::Param::InvalidParameterError, with: :invalid_parameter

  def invalid_parameter(exception)
    render json: {
      status: 400,
      message: exception.message,
    }, status: 400
  end

  def authenticate_api_token!
    token = http_auth_header

    if token.present?
      api_token = ApiToken.find_by(token: token)

      if api_token.present?
        sign_in(api_token.user, scope: :user)
        return true
      end
    end

    render_unauthorized
  end

  def page_param
    params[:page] || 1
  end

  def per_param
    [params[:per] || 25, 25].min
  end

  def request_origin
    if request.host == 'localhost'
      "#{request.protocol}#{request.host_with_port}"
    else
      "#{request.protocol}#{request.host}"
    end
  end

  protected

  def render_unauthorized
    render json: { status: :unauthorized }, status: :unauthorized
  end

  def render_bad_request(error)
    render json: {
      status: :bad_request,
      error: message_or_nil(error),
    }, status: :bad_request
  end

  private

  def http_auth_header
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def message_or_nil(error)
    return error.message if error
    nil
  end
end
