require 'rails_helper'

describe Mutations::Authentication::RegisterUser do
  setup do
    @email = Faker::Internet.email
    @last_name = Faker::Name.last_name
    @first_name = Faker::Name.first_name
    @birthday = Faker::Date.birthday
  end

  it 'Register new user' do
    user = Mutations::Authentication::RegisterUser.new(object: nil, field: nil, context: {}).resolve(
      email:                @email,
      password:             ['omitted'],
      last_name:            @last_name,
      first_name:           @first_name,
      birthday:             @birthday,
      confirmation_token:   Jwt::Encoder.new(@email).call,
      confirmation_sent_at: Time.zone.now
    )

    assert user.persisted?
    assert_equal user.last_name, @last_name
    assert_equal user.first_name, @first_name
    assert_equal user.birthday, @birthday
    assert_equal user.unconfirmed_email, @email
    assert_nil user.email
  end
end
