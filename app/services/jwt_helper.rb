# A set of helper functions for working with JWT in scope of this project.
# This is an entry point of all JWT interactions.

module JwtHelper
  extend self
  ALGORITHM = 'HS256'.freeze
  RFC7519_REGISTERED_CLAIM_NAMES = %w[iss sub aud exp nbf iat jti].freeze

  def encode_user(user)
    encode({ id: user.id })
  end

  def encode(payload)
    JWT.encode(payload, get_secret, ALGORITHM)
  end

  def decode(token, options = {})
    merged_options = {
      verify_expiration: false,
      verify_not_before: false,
      verify_iss: false,
      verify_iat: false,
      verify_jti: false,
      verify_aud: false,
      verify_sub: false,
      leeway: 30
    }.merge(options)

    payload, _header = JWT.decode(token, get_secret, true, merged_options)
    payload.except!(*RFC7519_REGISTERED_CLAIM_NAMES)

    HashWithIndifferentAccess.new(payload)
  end

  def get_secret
    Rails.application.secrets.secret_key_base
  end
end
