module Jwt
  class Decoder
    def initialize(token)
      @token = token
    end

    def call
      decode
    end

    def decode!
      res = JWT.decode(@token, Jwt::Secret.secret, true, { algorithm: 'HS256' }).first
      raise StandardError, 'Invalid token' if res.blank?

      res.symbolize_keys
    end

    def decode
      decode!
    rescue StandardError
      'Access token decoding error'
    end
  end
end
