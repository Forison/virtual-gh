# frozen_string_literal: true

module Mutations
  module Authentication
    class UnlockUser < BaseMutation
      argument :unlock_token, String, required: true

      def resolve(unlock_token:)
        email = Jwt::Decoder.new(unlock_token).call[:result]
        user = User.find_by(email:)
        raise 'Email is already unlocked' if user.nil?

        user.update(failed_attempts: 0)
        Authentication::UserAccountMailer.with(user:).lock_account.deliver_later
        user
      end
    end
  end
end
