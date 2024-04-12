require 'rails_helper'

describe Mutations::Authentication::ConfirmUser do
  setup do
    @user = Mutations::Authentication::RegisterUser.new(object: nil, field: nil, context: {}).resolve(
      email:                Faker::Internet.email,
      password:             ['omitted'],
      last_name:            Faker::Name.last_name,
      first_name:           Faker::Name.first_name,
      birthday:             Faker::Date.birthday,
      confirmation_token:   Jwt::Encoder.new(@email).call,
      confirmation_sent_at: Time.zone.now
    )
    @perform = Mutations::Authentication::ConfirmUser.new(object: nil, field: nil, context: {})
  end
  it 'Confirm newly created user email' do
    result = @perform.resolve(
      confirmation_token: @user.confirmation_token
    )
    assert_equal result, @user
    assert_equal result.unconfirmed_email, ''
    assert_equal result.email, @user.unconfirmed_email
  end
end
