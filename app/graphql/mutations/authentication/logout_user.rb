module Mutations
  module Authentication
    class LogoutUser < BaseMutation
      def resolve
        context[:session].delete(:user_id)
        @current_user = nil
      end
    end
  end
end
