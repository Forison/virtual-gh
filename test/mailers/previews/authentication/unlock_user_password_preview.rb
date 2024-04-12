require 'factory_bot_rails'

# preview email: http://localhost:5000/rails/mailers/authentication/unlock_user_mailer/lock_account
module Authentication
  class UnlockUserMailerPreview < ActionMailer::Preview
    include FactoryBot::Syntax::Methods

    def lock_account
      user = create(:user, :with_unlock_user_token)
      Authentication::UserAccountMailer.with(user:).lock_account
    end
  end
end
