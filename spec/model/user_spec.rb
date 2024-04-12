require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe User, type: :model do
  # it "associations" do
  #  p @user
  # Association for user model test would be here
  # end

  describe 'validation' do
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :birthday }
  end
  describe 'Testing instance methods for user model' do
    it '#name' do
      user = create(:user, last_name: 'John', first_name: 'Doe')
      assert_equal user.name, 'John Doe'
    end
    it '#reached_max_attempts_limit?' do
      user_one = create(:user, last_name: 'John', first_name: 'Doe', failed_attempts: (8..10).to_a.sample)
      assert_equal user_one.reached_max_attempts_limit?, true
      user_two = create(:user, last_name: 'John', first_name: 'Doe', failed_attempts: (1..7).to_a.sample)
      assert_equal user_two.reached_max_attempts_limit?, false
    end
    it '#confirmed?' do
      confirmed_user = create(:user, :with_confirmed_user)
      unconfirmed_user = create(:user, :with_unconfirmed_user)
      assert_equal confirmed_user.confirmed?, true
      assert_equal unconfirmed_user.confirmed?, false
    end
  end

  describe 'user roles' do
    it 'if no role is specified at sign up, user role is student' do
      user = create(:user)
      assert_equal user.role, 'student'
    end
    it 'if role is specified at sign up, user role is equal to role specified' do
      role = ['teacher', 'headteacher', 'admin'].sample
      user = create(:user, role:)
      assert_equal user.role, role
    end
  end
end
# rubocop:enable Metrics/BlockLength
