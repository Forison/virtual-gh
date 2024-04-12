module Authentication
  class ConfirmUserMailer < ApplicationMailer
    def welcome
      @user = params[:user]
      @confirm_account_url = authentication_url(email_type: 'cum', token: @user.confirmation_token)
      mail(
        to:      @user.unconfirmed_email,
        subject: 'Confirm Password',
        date:    Time.zone.now
      )
    end
  end
end
