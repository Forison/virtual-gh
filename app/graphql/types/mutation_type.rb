# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Authentication related mutations
    field :register_user, Types::UserType, null: false, mutation: Mutations::Authentication::RegisterUser
    field :signin_user, Types::UserType, null: false, mutation: Mutations::Authentication::SigninUser
    field :confirm_user, Types::UserType, null: false, mutation: Mutations::Authentication::ConfirmUser
    field :reset_password, Types::UserType, null: false, mutation: Mutations::Authentication::ResetPassword
    field :forgot_password, Types::UserType, null: false, mutation: Mutations::Authentication::ForgotPassword
    field :unlock_user, Types::UserType, null: false, mutation: Mutations::Authentication::UnlockUser
    field :logout_user, Types::UserType, null: false, mutation: Mutations::Authentication::LogoutUser
  end
end
