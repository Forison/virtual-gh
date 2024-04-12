# frozen_string_literal: true

module Mutations
  module Authentication
    class ConfirmUser < BaseMutation
      argument :confirmation_token, String, required: true

      def resolve(confirmation_token:)
        email = Jwt::Decoder.new(confirmation_token).call[:result]
        user = User.find_by(unconfirmed_email: email)
        raise 'Email is already confirmed' if user.nil?

        user.update(
          email:,
          unconfirmed_email: '',
          confirmed_at:      Time.zone.now
        )
        user
      end
    end
  end
end
