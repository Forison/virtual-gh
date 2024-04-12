require 'rails_helper'
# rubocop:disable Metrics/BlockLength
describe Mutations::Authentication::SigninUser do
  setup do
    @confirmed_email = Faker::Internet.email
    @user = create(:user, email: @confirmed_email)
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @perform = Mutations::Authentication::SigninUser.new(object: nil, field: nil, context: {})
    @login_attempts = 0
  end

  it 'Sign user with correct credentials' do
    result = @perform.resolve(email: @user.email, password: @user.password)
    assert_equal result, @user
    expect(@user.failed_attempts).to be == @login_attempts
  end
  it 'Try signing in user with wrong credentials' do
    expect { @perform.resolve(email: @email, password: @password) }.to raise_exception
  end
  it 'Try signing in user without providing credentials' do
    expect { @perform.resolve(email: '', password: '') }.to raise_exception
  end

  it 'Try signing in user with correct password only' do
    expect { @perform.resolve(email: '', password: @user.password) }.to raise_exception
  end

  it 'Try signing in user with correct email only' do
    expect { @perform.resolve(email: @user.email, password: '') }.to raise_exception
  end

  it 'Try signing in user with wrong password only' do
    expect { @perform.resolve(email: '', password: @password) }.to raise_exception
  end

  it 'Try signing in user with wrong password only' do
    expect { @perform.resolve(email: @email, password: '') }.to raise_exception
  end

  it 'Try signing in user with wrong password but correct email' do
    expect { @perform.resolve(email: @user.email, password: @password) }.to raise_exception
  end

  it 'Try signing in user with correct password but wrong email' do
    expect { @perform.resolve(email: @email, password: @user.password) }.to raise_exception
  end
end
# rubocop:enable Metrics/BlockLength
