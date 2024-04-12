module Mutations
  module Authentication
    class SigninUser < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      def resolve(email:, password:)
        user = User.find_by(email:)
        raise GraphQL::ExecutionError, 'Please create an account' unless user

        lock_user(user) if user.reached_max_attempts_limit?

        if user&.authenticate(password) && !user.reached_max_attempts_limit?
          reset_login_attempt(user)
          p "------->>>> #{context}"
          context[:session][:user_id] = user.id
          user
        else
          user.update!(failed_attempts: user.failed_attempts += 1)
          raise GraphQL::ExecutionError, 'Invalid email or password'
        end
      end

      private

      def lock_user(user)
        user.update(
          unlock_token: Jwt::Encoder.new(user.email).call,
          locked_at:    Time.zone.now
        )
        # dispatch unlock account email here
        Rails.logger.debug 'User has been locked'
        raise GraphQL::ExecutionError,
              'Account has been block, a message has been sent to your account to help you recover account'
      end

      def reset_login_attempt(user)
        return unless user.failed_attempts.positive?

        user.update!(failed_attempts: 0)
      end
    end
  end
end
