module Jwt
  class Authenticator
    def initialize(headers)
      @headers = headers
    end

    def call
      token = authenticate_header
      raise StandardError, 'Token not found' if token.blank?

      decoded_token = Jwt::Decoder.decode!(token)
      user = authenticate_user_from_token(decoded_token)
      raise StandardError, 'User is unauttorized' if user.blank?

      user
    end

    def authenticate_header
      @headers['Authorization']&.split('Bearer ')&.last
    end

    # def authenticate_user_from_token(decoded_token)
    #   raise StandardError, "Token is invalid" unless decoded_token[:jti].present? && decoded_token[:user_id].present?

    #   User.find(decoded_token.fetch(:user_id))
    # end
  end
end
