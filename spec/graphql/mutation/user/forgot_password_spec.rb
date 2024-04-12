require 'rails_helper'

describe Mutations::Authentication::ForgotPassword do
  setup do
    @user = create(:user, :with_reset_password_token)
    @perform = Mutations::Authentication::ForgotPassword.new(object: nil, field: nil, context: {})
  end

  it 'Create a confirmation token and dispatch token as part of reset password email' do
    result = @perform.resolve(
      email: @user.email
    )
    assert_equal result.allow_password_change, true
  end
end
