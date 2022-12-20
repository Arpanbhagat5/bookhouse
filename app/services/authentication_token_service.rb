# frozen_string_literal: true

# Got rid of this by using `require: true` in gemfile
# require 'jwt'

class AuthenticationTokenService
  # Define constants
  # Try constant with freeze -> rubocop cleans it out
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  ALGORITHM_TYPE = 'HS256'

  def self.invoke(user_id)
    expiry = 24.hours.from_now.to_i
    payload = {
      user_id:,
      expiry:
    }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end

  # To be used in checking API auth
  def self.valid_payload(payload)
    !expired(payload)
  end

  def self.expired(payload)
    Time.now > Time.at(payload['expiry'])
  end

  def self.expired_token
    render json: { error: 'Expired token! login again' }, status: :unauthorized
  end
end
