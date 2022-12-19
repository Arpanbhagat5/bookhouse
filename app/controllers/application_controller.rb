# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # Exception avoids errors that occur in case of failed destroy method
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  # To safegaurd our API endpoints
  # ** Trying method_name!
  # check for valid paylod, followed by valid user
  # Return error if either fail
  def authenticate_request!
    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)

    current_user!
    invalid_authentication unless @current_user
  end


  private

  # Helper to extract user_id from payload
  def current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  # Helper to extract token from request headers
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split.last
    AuthenticationTokenService.decode(token)
    # rescue StandardError
    #   nil
  end

  # Helper to render invalid authentication messages
  def invalid_authentication
    render json: { error: 'You will need to login first' }, status: :unauthorized
  end

end
