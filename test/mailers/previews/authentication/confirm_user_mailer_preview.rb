require 'factory_bot_rails'

# Email preview url: http://localhost:5000/rails/mailers/authentication/confirm_user_mailer/welcome
module Authentication
  class ConfirmUserMailerPreview < ActionMailer::Preview
    include FactoryBot::Syntax::Methods

    def welcome
      user = create(:user, :with_unconfirmed_user)
      Authentication::ConfirmUserMailer.with(user:).welcome
    end
  end
end
