require 'rails_helper'

module Authentication
  class ForgotPasswordMailerTest < ActionMailer::TestCase
    describe '::ForgotPasswordMailer' do
      it 'dispatch account password reset request email' do
        user = create(:user, :with_reset_password_token, email: 'foo@bar.com')
        email = Authentication::ForgotPasswordMailer.with(user:).change_password_request
        assert_emails(1) { email.deliver_later }
        delivered_email = ActionMailer::Base.deliveries.last
        assert_includes delivered_email.text_part.body.to_s, user.reset_password_token
        assert_includes delivered_email.html_part.body.to_s, user.reset_password_token
      end
    end
  end
end
