require 'rails_helper'

module Authentication
  class UserAccountMailerTest < ActionMailer::TestCase
    describe '::UserAccountMailer' do
      it 'dispatch a account confirmation email after a user is registered' do
        user = create(:user, :with_unlock_user_token)
        email = Authentication::UserAccountMailer.with(user:).lock_account
        assert_emails(1) { email.deliver_later }
        delivered_email = ActionMailer::Base.deliveries.last
        assert_includes delivered_email.text_part.body.to_s, user.unlock_token
        assert_includes delivered_email.html_part.body.to_s, user.unlock_token
      end
    end
  end
end
