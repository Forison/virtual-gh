require 'rails_helper'

module Authentication
  class ConfirmUserMailerTest < ActionMailer::TestCase
    describe '::ConfirmUserMailer' do
      it 'dispatch a account confirmation email after a user is registered' do
        user = create(:user, :with_unconfirmed_user)
        email = Authentication::ConfirmUserMailer.with(user:).welcome
        assert_emails(1) { email.deliver_later }
        delivered_email = ActionMailer::Base.deliveries.last
        assert_includes delivered_email.text_part.body.to_s, user.confirmation_token
        assert_includes delivered_email.html_part.body.to_s, user.confirmation_token
      end
    end
  end
end
