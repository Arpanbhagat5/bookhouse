# frozen_string_literal: true

class AuthenticationTokenService
  # Define constants
  # Try constant with freeze
  ALGORITHM_TYPE = 'HS256'
  HMAC_SECRET = Rails.application.secrets.secret_key_base

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
