module Jwt
  class Encoder
    def initialize(payload)
      @payload = payload
    end

    def call
      jti = SecureRandom.hex
      exp = token_expiry
      JWT.encode(
        { result: @payload, jti:, iat: token_issued_at.to_i, exp: },
        Jwt::Secret.secret,
        'HS256'
      )
    end

    def token_expiry
      (token_issued_at + Jwt::Expiry.expiry).to_i
    end

    def token_issued_at
      Time.zone.now
    end
  end
end
