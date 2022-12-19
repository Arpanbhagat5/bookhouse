class AuthenticationTokenService
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  # Try constant with freeze
  ALGORITHM_TYPE = 'HS256'.freeze

  def self.invoke(user_id)
    exp = 24.hours.from_now.to_i
    payload = { 
      user_id: user_id,
      exp: exp
    }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    JWT.decode token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE }
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end

  # Redundant method
  def self.valid_payload(payload)
    !expired(payload)
  end

  def self.expired(payload)
    Time.now > Time.at(payload['exp'])
  end

  def self.expired_token
    render json: { error: 'Expired token! login again' }, status: :unauthorized
  end
end